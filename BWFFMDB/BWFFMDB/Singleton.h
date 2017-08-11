//
//  Singleton.h
//  BWFFMDB
//
//  Created by BWF-HHW on 16/6/17.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Model;

@interface Singleton : NSObject

+ (Singleton *)shareSingleTon;














//插入
- (void)insertDBWithName:(NSString *)name Age:(NSInteger)age ID:(NSInteger)userID;
//删除
- (void)deleteAllData;
- (void)deleteWithID:(NSInteger)tbID;
//修改
- (void)updateTBWithID:(NSInteger)tbID name:(NSString *)aName;
//查询
- (NSMutableArray *)getModelFromFMDB;


@end
