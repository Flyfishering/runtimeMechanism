//
//  Person.h
//  RuntimeMechanism
//
//  Created by seasaw on 2018/6/7.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
// 打印姓名：name 
- (void)logName:(NSString *)name;
// 玩游戏
- (void)playGame:(NSString *)game;
// 吃东西
- (void)eatingFood:(NSString *)food;
@end
