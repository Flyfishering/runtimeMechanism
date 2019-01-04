//
//  main.m
//  RuntimeDemo02
//
//  Created by 斌 on 2019/1/2.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RuntimeDemo02Manager.h"
#import "AllClassDemo.h"
//#import "MySubClass.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        [RuntimeDemo02Manager testMethod1];
        [RuntimeDemo02Manager testMethod2];
//        [RuntimeDemo02Manager testMethod3];
        [AllClassDemo testMethod1];
        
    }
    return 0;
}
