//
//  main.m
//  RuntimeMechanism
//
//  Created by seasaw on 2018/6/7.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Person *person = [[Person alloc] init];
        [person logName:@"王斌斌"];
//        [person playGame:@"英雄联盟"];
//        [person eatingFood:@"臊子面"];
    }
    return 0;
}
