//
//  MyClass.m
//  RuntimeDemo02
//
//  Created by 斌 on 2019/1/2.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import "MyClass.h"
@interface MyClass () {
    NSInteger       _instance1;
    NSString    *   _instance2;
}
@end 
@implementation MyClass

+ (void)classMethod1{
}
- (void)method1 {
    NSLog(@"call method method1");
}
- (void)method2 {
}
- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}

- (void)logMethods{
    NSLog(@"打印方法");
}
@end
