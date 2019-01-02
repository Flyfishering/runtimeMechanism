//
//  RuntimeManager.m
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/8.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import "RuntimeManager.h"
#import "Person.h"
#import "Friends.h"
#import "Friends01.h"
#import <objc/runtime.h>
@implementation RuntimeManager

#pragma - 获取成员变量 包括属性值和成员变量
- (void)getAllIvarList{
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (unsigned int i=0; i< count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
    free(ivarList);
}

#pragma - 获取所有属性变量
- (void)getAllPropertys{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
    free(propertyList);
}
#pragma - 获取所有方法   包括所有属性的 get 和 set 方法
- (void)getAllMethods{
    unsigned int count = 0;
    Method *methodList = class_copyMethodList([Person class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    free(methodList);
}


#pragma -  获取所有协议
- (void)getAllProtocols{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([Person class], &count);
    for (unsigned int i = 0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    free(protocolList);
}

#pragma -  动态变量控制
- (void)modifyPropertysValue{
    Friends *friends = [[Friends alloc] init];
    friends.age = 20;
    NSLog(@"修改 age 之前, friends.age = %ld",friends.age);
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Friends class], &count);
    for (unsigned int i = 0; i < count; i++){
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivars[i]);
        NSString *nameObj = [NSString stringWithUTF8String:name];
        if([nameObj containsString:@"age"]){
            NSLog(@"nameObj = %@",nameObj);
            NSLog(@"ivar = %s",ivar_getName(ivar));
            object_setIvar(friends, ivar, @13);
            NSLog(@"修改 age 之后, friends.age = %@",object_getIvar(friends, ivar));
            // 打印结果 修改 age 之后, friends.age = 13
            NSLog(@"修改 age 之后, friends.age = %ld",friends.age);
            // 打印结果: 修改 age 之后, friends.age = 3367
            
            /*
             使用 runtime 改变了 成员变量的值后，最好也用 runtime 来获取该成员变量的值。
             使用 get 方法获取的值不一定对，尤其是对数值类型的成员变量值的获取，没找到原因
                本以为是 通过 runtime 改变值 不会触发 kvc ， 好像不是这样的。以后有时间再去找原因。
             */
        }
    }
    // 记得释放 ivars
    free(ivars);
}

#pragma -  动态添加方法
- (void)dynamicAddMethod{
    
    // 动态添加方法
    SEL logFriendsName = sel_registerName("LogFriendsName");
    class_addMethod([Friends class], logFriendsName, (IMP)printName, "v@:");
    
    // 调用方法
    Friends *friends = [[Friends alloc] init];
    [friends performSelector:logFriendsName];
}

void printName(void){
    NSLog(@"friend name = 李某某");
}

#pragma -  交换方法
- (void)exchangeMethods{
    Friends *friend = [[Friends alloc] init];
    Method method1 = class_getInstanceMethod([Friends class], @selector(playGame));
    Method method2 = class_getInstanceMethod([Friends class], @selector(eatingFoods));
    method_exchangeImplementations(method1, method2);
    
    [friend eatingFoods];// 打印：那家伙 正在打游戏
    [friend playGame];//  凑不要脸的 吃东西也不叫我
}

#pragma -  拦截替换方法
- (void)interceptReplaceMethod{
    // 原方法的 medthod  和 SEL
    SEL sel1 = @selector(playGame);
    Method method1 = class_getInstanceMethod([Friends class], sel1);
    
    // 要替换的 method 和 SEL
    SEL sel2 = @selector(playGame01);
    Method method2 = class_getInstanceMethod([Friends01 class], sel2);
    // 常识给 Friends 添加方法 playGame01 的实现
    BOOL addSucc = class_addMethod([Friends class], @selector(playGame), method_getImplementation(method2), "v@:");
    if (addSucc) {
        // 如果添加成功，则把 原方法的实现替换成交换方法的实现
        class_replaceMethod([Friends01 class], sel2, method_getImplementation(method1), method_getTypeEncoding(method1));
    }else{
        //添加失败：说明源方法已经有实现，直接将两个方法的实现交换
        method_exchangeImplementations(method1, method2);
    }
    
    // 也可以直接替换方法
//    class_replaceMethod([Friends class], @selector(playGame), method_getImplementation(method2), "v@:");
    Friends *friend = [[Friends alloc] init];
    [friend playGame];
//    Friends01 *friend01 = [[Friends01 alloc] init];
//    [friend01 playGame01];
    
}

// 给方法添加额外的功能 项目中，经常会在原来的老方法里添加功能, 用 runtime 可以很巧妙的解决这个问题
- (void)methodAddFeature{
    Friends *friend = [[Friends alloc] init];
    [friend learnSomeThing];
}

@end
