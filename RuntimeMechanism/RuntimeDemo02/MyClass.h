//
//  MyClass.h
//  RuntimeDemo02
//
//  Created by 斌 on 2019/1/2.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject<NSCopying, NSCoding>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;
- (void)method1;
- (void)method2;
+ (void)classMethod1;

@end

NS_ASSUME_NONNULL_END
