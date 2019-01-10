//
//  RuntimeDemo02Manager.h
//  RuntimeDemo02
//
//  Created by 斌 on 2019/1/2.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeDemo02Manager : NSObject
/// 类和对象 runtime 基本操作
+ (void)testMethod1;
/// 动态创建类，添加方法，添加实例等
+ (void)testMethod2;
/// 类型编码
+ (void)testMethod3;
+ (void)testMethod4;
@end

NS_ASSUME_NONNULL_END
