//
//  RuntimeManager.h
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/8.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeManager : NSObject
/* 获取所有属性列表 包括属性变量和成员变量*/
- (void)getAllIvarList;
// 获取所有属性变量
- (void)getAllPropertys;
// 获取所有方法
- (void)getAllMethods;
// 获取所有协议
- (void)getAllProtocols;
// 动态变量控制
- (void)modifyPropertysValue;
// 动态添加方法
- (void)dynamicAddMethod;
// 交换方法
- (void)exchangeMethods;
// 拦截替换方法
- (void)interceptReplaceMethod;
// 给方法添加额外的功能
- (void)methodAddFeature;
@end
