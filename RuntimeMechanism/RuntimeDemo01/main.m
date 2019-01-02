//
//  main.m
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/8.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "RuntimeManager.h"
#import "RuntimeManager01.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        typedef struct structValue{
//            int age;
//            char *descrip;
//        }sturctname;
        
//        char *buf1 = @encode(int);
//        char *buf2 = @encode(char);
//        char *buf3 = @encode(long double);
//        char *buf4 = @encode(void);
//        char *buf5 = @encode(Class);
//        char *buf6 = @encode(id);
//        char *buf7 = @encode(char *);
//        char *buf8 = @encode(NSArray *);
//        char *buf9 = @encode(float);
//        char *buf10 = @encode(bool);
//        char *buf12 = @encode(sturctname);
////        char *buf13 = @encode(union);
//        NSLog(@"buf1 = %s",buf1);//buf1 = i   //int
//        NSLog(@"buf2 = %s",buf2);//buf2 = c   //char
//        NSLog(@"buf3 = %s",buf3);//buf3 = D   //(long double)
//        NSLog(@"buf4 = %s",buf4);//buf4 = v   //void
//        NSLog(@"buf5 = %s",buf5);//buf5 = #   //Class
//        NSLog(@"buf6 = %s",buf6);//buf6 = @   //id
//        NSLog(@"buf7 = %s",buf7);//buf7 = *   //char *
//        NSLog(@"buf8 = %s",buf8);//buf8 = @   //NSArray *
//        NSLog(@"buf9 = %s",buf9);//buf9 = f   //float
//        NSLog(@"buf10 = %s",buf10);//buf10 = B //bool
//        NSLog(@"buf12 = %s",buf12);//buf12 = {structValue=i*} //
//        NSLog(@"buf13 = %s",buf13);
        
        RuntimeManager *manager = [[RuntimeManager alloc] init];
        [manager getAllIvarList];
        [manager getAllPropertys];
        [manager getAllMethods];
        [manager getAllProtocols];
        [manager modifyPropertysValue];
        [manager dynamicAddMethod];
        [manager exchangeMethods];
        [manager interceptReplaceMethod];
        [manager methodAddFeature];
        
        
        RuntimeManager01 *manager01 = [[RuntimeManager01 alloc] init];
        // 归档
        [manager01 archiveObject];
        // 解档
        [manager01 loadArchive];
        
    }
    return 0;
}

