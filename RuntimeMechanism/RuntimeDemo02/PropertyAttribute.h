//
//  PropertyAttribute.h
//  RuntimeDemo02
//
//  Created by wangbinbin on 2019/1/3.
//  Copyright © 2019 wangbinbin. All rights reserved.
//

#import <Foundation/Foundation.h>
//https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6

// -[Type Encodings](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1)
// -[Declared Properties](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html#//apple_ref/doc/uid/TP40008048-CH101-SW6)
NS_ASSUME_NONNULL_BEGIN


/// 规则
//T数据类型,read或者write,内存管理.原子性,get或者set方法,V_属性名
// 如：T@,R,&,N,V_idReadonlyRetainNonatomic
enum FooManChu { FOO, MAN, CHU };
struct YorkshireTeaStruct { int pot; char lady; };
typedef struct YorkshireTeaStruct YorkshireTeaStructType;
union MoneyUnion { float alone; double down; };

@interface PropertyAttribute : NSObject
@property char charDefault;
@property double doubleDefault;
@property enum FooManChu enumDefault;
@property float floatDefault;
@property int intDefault;
@property long longDefault;
@property short shortDefault;
@property signed signedDefault;
@property struct YorkshireTeaStruct structDefault;
@property YorkshireTeaStructType typedefDefault;
@property union MoneyUnion unionDefault;
@property unsigned unsignedDefault;
@property int (*functionPointerDefault)(char *);
@property id idDefault;
@property int *intPointer;
@property void *voidPointerDefault;
@property int intSynthEquals;
@property(getter=intGetFoo, setter=intSetFoo:) int intSetterGetter;
@property(readonly) int intReadonly;
@property(nonatomic,getter=isIntReadOnlyGetter, readonly) int intReadonlyGetter;
@property(readwrite) int intReadwrite;
@property(assign) int intAssign;
@property(retain) id idRetain;
@property(copy) id idCopy;
@property(nonatomic) int intNonatomic;
@property(nonatomic, readonly, copy) id idReadonlyCopyNonatomic;
@property(nonatomic, readonly, retain) id idReadonlyRetainNonatomic;
@end

NS_ASSUME_NONNULL_END
