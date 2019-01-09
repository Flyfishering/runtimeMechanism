//
//  RuntimneArcDemo.m
//  RuntimeDemo02
//
//  Created by wangbinbin on 2019/1/9.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import "RuntimneArcDemo.h"
#import <objc/runtime.h>

@implementation RuntimneArcDemo
// 获取所有注册类
+ (void)testMethod{
    int numClasses;
    Class * classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    NSLog(@"numClasses = %ld",numClasses);
    if (numClasses > 0) {
        classes = malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        NSLog(@"number of classes: %d", numClasses);
        for (int i = 0; i < numClasses; i++) {
            Class cls = classes[i];
            NSLog(@"class name: %s", class_getName(cls));
        }
        free(classes);
    }
}
@end
