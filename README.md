# iOS 黑魔法 runtime 消息转发 
Objective-C  runtime demo， 如果你看到，千万别错过(看完后，保证你掌握 runtime)


> 接私活 qq 1004598460

- [简书地址](https://www.jianshu.com/p/aee8f6835c46)
- [掘金地址](https://juejin.im/post/5b1937576fb9a01e4230b5ae)

runtime 其实并不难，不信，你往下看。 哥从来不骗人。

![消息转发流程图](https://user-gold-cdn.xitu.io/2018/6/7/163da8bab3c73bf9?w=713&h=406&f=png&s=72380)
###对象接收到一个不能响应的消息，runtime 的转发过程如上图。

------
> [demo地址](https://github.com/Flyfishering/runtimeMechanism.git)
------

有个一个 `Person` 类：
Person.h 文件
```
@interface Person : NSObject
// 打印姓名：name 
- (void)logName:(NSString *)name;
// 玩游戏
- (void)playGame:(NSString *)game;
// 吃东西
- (void)eatingFood:(NSString *)food;

@end

```
Person.m 文件
```
#import "Person.h"

@implementation Person
// 这里面什么都没有写，
@end
```

我们只声明了方法 `- (void)logName:(NSString *)name;` 并没有实现它
当我们调用这个方法时，会抛出异常：

```
Person *person = [[Person alloc] init];
[person logName:@"王斌斌"];
//        [person playGame:@"英雄联盟"];
//       [person eatingFood:@"臊子面"];
```
异常：
```
Terminating app due to uncaught exception 'NSInvalidArgumentException', 
reason: '-[Person logName:]: unrecognized selector sent to instance 0x100706c50'
```
--------

### 通过消息转发可以避免这种异常。
-  动态方法解析
在方法 `resolveInstanceMethod` 中 给方法 `logName` 添加实现

```
/*
sel: 一个 selector 名字， 这里要实现这个 sel 的 imp
return: 如果 sel 对应的方法找到了，或者已经加入接受者中，返回YES, 否则 返回 NO
notice: 只有在 该类及其继承体系中都没有实现 sel 时，才会走到这个方法， 给 sel 指定实现函数
*/
+ (BOOL)resolveInstanceMethod:(SEL)sel;
```
这个方法可以动态的为给定的 实例方法 的 selector 一个实现。
这个方法和 `resolveClassMethod` 都允许给指定的 selector 提供一个实现。
一个 Objective-C 方法其实就是一个 C 语言函数，这个函数至少有两个参数 (self, _cmd)，使用函数 `class_addMethod` 可以为类添加一个方法
```
// 这是一个 C 语言函数
void logNameIMP(id self, SEL _cmd,NSString *s){
NSLog(@"打印name: %@",s);
}
```

我们可以使用 方法:`resolveInstanceMethod` 动态的给类添加一个方法`resolveThisMethodDynamically`

在 `Person.m` 中加入下面的代码
```
+ (BOOL)resolveInstanceMethod:(SEL)sel{

if (sel == @selector(logName:)){
/*
class : 类名
name: sel
imp: 函数地址
types: 类型编码 测试可以为nil
class_addMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,const char * _Nullable types)
*/
class_addMethod([self class], sel, (IMP)logNameIMP, "v@:@");
return YES;
}
return [super resolveInstanceMethod:sel];
}
```
运行结果:
`打印name: 王斌斌`

执行代码 `[person playGame:@"英雄联盟"]`
但是这个时候，方法`playGame`还是会报错，因为我们上面只实现了 `logName`的动态绑定。
这个方法里没有动态添加 `playGame` sel 实现，则继续走下一步 *备用接受者*

---

- 备用接收者

```
/*
aSelector : 这个对象没 未实现的 sel
return id: 实现了 sel 的对象(另外一个对象)
*/
- (id)forwardingTargetForSelector:(SEL)aSelector
```

---

```
- (id)forwardingTargetForSelector:(SEL)aSelector{
if(aSelector == @selector(playGame:)){
Kids *kids = [[Kids alloc] init];
return kids;
}
return [super forwardingTargetForSelector:aSelector];
}

```
当 `Person` 发送一个它不能识别的方法，而另外一个对象 `Kids` 实现了这个方法，我们就返回这个实现了方法的对象，让它去处理这个方法
不能返回 self，会死循环

如果没有要返回的对象 就返回 ` [super forwardingTargetForSelector:aSelector]`

这个方法在 更耗资源的方法 `forwordInvocation:` 之前调用。
在这个方法里，你不能捕获 NSInvocation， 修改 参数和返回值，也就是说，你只能完完整整的转发这个方法，不能修改方法的参数和返回值

Kids.h
```
@interface Kids : NSObject
// 玩游戏
- (void)playGame:(NSString *)game;
@end

```
----
kids.m

```
@implementation Kids
// 玩游戏
- (void)playGame:(NSString *)game{
NSLog(@"孩子们在玩 %@",game);
}
@end
```
运行打印:
`孩子们在玩 英雄联盟`


这时候，执行方法 `[person eatingFood:@"臊子面"];` 还是会报错。 下面继续看
- 完整消息转发
上一步还不能处理未知消息，只有采用完整的方法转发机制了。


```
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
NSMethodSignature *methodSignature = [NSMethodSignature methodSignatureForSelector:aSelector];
if (!methodSignature){
return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}
return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
SEL sel = [anInvocation selector];
if (sel == @selector(eatingFood:)){
[anInvocation invokeWithTarget:[[Guys alloc] init]];
}
}
```
打印结果:
`这群家伙正在吃: 臊子面`


---
我们来详细介绍下这两个方法
`methodSignatureForSelector `
`forwardInvocation `
1. 方法签名
```
/*
aSelector : 方法选择器
return NSMethodSignature: 方法签名

通过类型编码直接创建方法签名： [NSMethodSignature signatureWithObjcTypes:"v@:"];

*/
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
```
NSMethodSignature 它封装了一个方法的返回类型和参数类型，记住它不包括方法名称，只有返回类型和参数类型


2. 消息转发：

```
/*
anInvocation: 要转发的消息
*/
- (void)forwardInvocation:(NSInvocation *)anInvocation;
```
重写这个方法，把消息转发给别的对象
当接收者接收一个不响应的消息时，runtime 机制中会委托另外一个接收者去接收这个消息
把消息包装成 NSInvocation 对象，并发送给 接收者的方法 `forwardInvocation`中，并且把生成的 NSInvocation 对象当做方法的参数传入
在方法 `forwardInvocation` 中 接收者 会把消息转发给另外一个接收者。（另外一个接收者 也可以通过这个机制 转发 给其他的接收者）
这个方法可以做很多事情：
* 配置 参数
* 配置 返回值
* 配置 调用对象等。

**可以为多个 selector 实现一个方法实现。
也可以将一个 selector 转发给多个对象。**

> `methodSignatureForSelector` 和 `forwardInvocation` 必须一起重写才会实现消息转发。
系统会自动实现 `NSInvocation *anInvocation = [[NSInvocation invocationWithMethodSignature:signature];` 
得到的 anInvocation 被传入了 方法 `- (void)forwardInvocation:(NSInvocation *)invocation`

- 抛出异常
上面层层转发进行下来，这个消息还是没有找到自己的归宿，就会抛出异常: 重写方法`doesNotRecognizeSelector` 可以定义我们的自定义异常信息
现在完整的消息转发机制就结束了。


现在，有关消息转发的知识都讲完了。具体实现大家可以查看 [demo](https://github.com/Flyfishering/runtimeMechanism.git)

---

- [补充类型编码](https://blog.csdn.net/ssirreplaceable/article/details/53376915)

-  [简书 宇杰笔记](https://www.jianshu.com/p/adf0d566c887)
