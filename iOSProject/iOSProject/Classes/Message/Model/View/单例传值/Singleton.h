//
//  Singleton.h
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Singleton : NSObject

//第三步：声明想要保存的数据类型
@property (nonatomic, retain) NSString *passString;

//第一步：创建声明单例方法
+ (Singleton *)shareSingleton;

@end
