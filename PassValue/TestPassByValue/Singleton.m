//
//  Singleton.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

//第二步：实现声明单例方法
+ (Singleton *)shareSingleton
{
    static Singleton *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Singleton alloc] init];
    });
    return singleton;
}

@end
