//
//  Friends.m
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/10.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import "Friends.h"
#import <objc/runtime.h>
@implementation Friends
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        SEL sel1 = @selector(learnSomeThing);
        Method method1 = class_getInstanceMethod([self class], sel1);
        
        SEL sel2 = @selector(mylearnSomeThing);
        Method method2 = class_getInstanceMethod([self class], sel2);
        
        
        BOOL addSucc = class_addMethod([self class], sel1, method_getImplementation(method2), method_getTypeEncoding(method2));
        if (addSucc) {
            class_replaceMethod([self class], sel2, method_getImplementation(method1), method_getTypeEncoding(method1));
        }else {
            method_exchangeImplementations(method1, method2);
        }
    });
}
- (void)playGame{
    NSLog(@"那家伙 正在打游戏");
}
- (void)eatingFoods{
    NSLog(@"凑不要脸的 吃东西也不叫我");
}

- (void)learnSomeThing{
    NSLog(@"那家伙正在搞学习");
}

- (void)mylearnSomeThing{
    // 在 load 中已经替换了方法， 这里看上去调用的是 learnSomeThing 方法，其实调用的是 mylearnSomeThing 方法
    NSLog(@"每天晚上。。。");
    [self mylearnSomeThing];
}



@end
