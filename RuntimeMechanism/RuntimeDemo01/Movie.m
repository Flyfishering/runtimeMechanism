//
//  Movie.m
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/10.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import "Movie.h"
#import <objc/runtime.h>
// 把代码抽成宏
#define encodeRuntime(A) \
\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([Movie class], &count);\
for (int i = 0; i<count; i++) {\
    Ivar ivar = ivars[i];\
    const char *name = ivar_getName(ivar);\
    NSString *key = [NSString stringWithUTF8String:name];\
    id value = [self valueForKey:key];\
    [encoder encodeObject:value forKey:key];\
}\
free(ivars);\
\

#define initCoderRuntime(A) \
if (self = [super init]) {\
unsigned int count = 0;\
Ivar *ivars = class_copyIvarList([Movie class], &count);\
for (int i = 0; i<count; i++) {\
    Ivar ivar = ivars[i];\
    const char *name = ivar_getName(ivar);\
    NSString *key = [NSString stringWithUTF8String:name];\
    id value = [decoder decodeObjectForKey:key];\
    [self setValue:value forKey:key];\
}\
free(ivars);\
}\
\


@implementation Movie
- (void)encodeWithCoder:(NSCoder *)encoder

{
//    unsigned int count = 0;
//    Ivar *ivars = class_copyIvarList([Movie class], &count);
//
//    for (int i = 0; i<count; i++) {
//        // 取出i位置对应的成员变量
//        Ivar ivar = ivars[i];
//        // 查看成员变量
//        const char *name = ivar_getName(ivar);
//        // 归档
//        NSString *key = [NSString stringWithUTF8String:name];
//        id value = [self valueForKey:key];
//        [encoder encodeObject:value forKey:key];
//    }
//    free(ivars);
    encodeRuntime(Movie);
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
//        unsigned int count = 0;
//        Ivar *ivars = class_copyIvarList([Movie class], &count);
//        for (int i = 0; i<count; i++) {
//            // 取出i位置对应的成员变量
//            Ivar ivar = ivars[i];
//            // 查看成员变量
//            const char *name = ivar_getName(ivar);
//            // 归档
//            NSString *key = [NSString stringWithUTF8String:name];
//            id value = [decoder decodeObjectForKey:key];
//            // 设置到成员变量身上
//            [self setValue:value forKey:key];
//        }
//        free(ivars);
        
        initCoderRuntime(Movie);
    }
    return self;
}

#pragma mark - NSCoping
- (id)copyWithZone:(NSZone *)zone {
    Movie *copy = [[[self class] allocWithZone:zone] init];
    copy.movieName = [self.movieName copyWithZone:zone];
    copy.movieId = self.movieId;
    copy.pic_url = [self.pic_url copyWithZone:zone];
    return copy;
}

@end
