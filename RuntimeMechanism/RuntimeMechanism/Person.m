//
//  Person.m
//  RuntimeMechanism
//
//  Created by seasaw on 2018/6/7.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Kids.h"
#import "Guys.h"
@implementation Person



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


- (id)forwardingTargetForSelector:(SEL)aSelector{
    if(aSelector == @selector(playGame:)){
        Kids *kids = [[Kids alloc] init];
        return kids;
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSMethodSignature *methodSignature = [NSMethodSignature methodSignatureForSelector:aSelector];
    if (!methodSignature){
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL sel = [anInvocation selector];
    if (sel == @selector(eatingFood:)){
        [anInvocation invokeWithTarget:[[Guys alloc] init]];
    }
}

void logNameIMP(id self, SEL _cmd,NSString *s){
    NSLog(@"打印name: %@",s);
}

@end
