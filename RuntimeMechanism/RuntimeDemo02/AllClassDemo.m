//
//  AllClassDemo.m
//  RuntimeDemo02
//
//  Created by 斌 on 2019/1/3.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import "AllClassDemo.h"
#import <objc/runtime.h>
@implementation AllClassDemo

///获取所有注册的类，所有被注册的类都会被打印。。。。。
+ (void)testMethod1{
    int numClasses;
    Class * classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        NSLog(@"numClasses = %d sizeof(Class) = %lu",numClasses ,sizeof(Class));
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
