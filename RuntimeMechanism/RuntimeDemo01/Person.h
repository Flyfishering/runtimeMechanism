//
//  Person.h
//  RuntimeDemo01
//
//  Created by seasaw on 2018/6/8.
//  Copyright © 2018年 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PersonProtocol01
- (void)personProtocol01Method01;
- (void)personProtocol01Method02;
- (void)personProtocol01Method03;
@end

@protocol PersonProtocol02
@end

@protocol PersonProtocol03
@end


@interface Person : NSObject<PersonProtocol01,PersonProtocol02,PersonProtocol03>
{
    int _ivarIntValue;
    char *_ivarCharValue;
}

@property (nonatomic, assign) char charV;
@property (nonatomic, assign) int intVaule;
@property (nonatomic, assign) short shortVaule;
@property (nonatomic, assign) long longVaule;
@property (nonatomic, assign) long long longlongVaule;
@property (nonatomic, assign) unsigned int unsignedIntVaule;
@property (nonatomic, assign) unsigned short unsignedShortVaule;
@property (nonatomic, assign) unsigned long unsignedlongVaule;
@property (nonatomic, assign) unsigned long long unsignedlonglongVaule;
@property (nonatomic, assign) float floatValue;
@property (nonatomic, assign) double doubleValue;
@property (nonatomic, assign) bool boolValue;
@property (nonatomic, assign) char *charValue;
@property (nonatomic, assign) Class class;
@property (nonatomic, assign) struct structValue;
@property (nonatomic, assign) union unionValue;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *books;
@property (nonatomic, strong) NSDictionary *dic;
//@property (nonatomic, assign) void ^(blockVlaue)(NSString *name) block;

- (void)method01;
- (void)method02;
- (void)method03;
- (void)method04;
- (void)method05;

@end
