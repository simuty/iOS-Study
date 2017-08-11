//
//  Singleton.m
//  BWFFMDB
//
//  Created by BWF-HHW on 16/6/17.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import "Singleton.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "Model.h"


#define K_PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]


#define K_DBPath @"test.sqlite"

@interface Singleton()

@property(nonatomic, copy)NSString *dbPath;

@end


@implementation Singleton

+ (Singleton *)shareSingleTon{
    
    static Singleton *singleTon;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleTon = [[Singleton alloc] init];
        [singleTon creatDB];
    });
    return  singleTon;
}




- (void)creatDB{

    //
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
   // NSString *doc = K_PATH_OF_DOCUMENT;
    self.dbPath = [doc stringByAppendingPathComponent:K_DBPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    
    NSLog(@"-----path ====%@", self.dbPath);
    
    if ([fileManager fileExistsAtPath:self.dbPath] == NO) {
      
        NSLog(@"-----创建-----");

        //创建数据库
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        
        
        if ([db open]) {
            
            NSString * sql = @"CREATE TABLE 'User' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'name' VARCHAR(30), 'age' INTEGER)";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"succ to creating db table");
            }
//关闭数据库
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    }


}

- (void)insertDBWithName:(NSString *)name Age:(NSInteger)age ID:(NSInteger)userID{


    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"insert or replace into user (name, age, id) values('%@', '%ld', '%ld')", name, age, userID];
        
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        
        [db close];
    }
}




//删除
- (void)deleteAllData{

    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];

    if ([db open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM user"];
        if (![db executeUpdate:sqlstr])
        {
            NSLog(@"Erase table error!");
            
        }
        [db close];
    }
}

- (void)deleteWithID:(NSInteger)tbID{

    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        NSString *sqlstr = [NSString stringWithFormat:@"DELETE FROM user where id = '%ld'", tbID];
        if (![db executeUpdate:sqlstr])
        {
            NSLog(@"Erase table error!");
            
        }
        [db close];
    }


}



- (void)updateTBWithID:(NSInteger)tbID name:(NSString *)aName;
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        
        NSString *sql = [NSString stringWithFormat:@"insert or replace into user (name, id) values('%@',  '%ld')", aName, tbID];
        
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        
        [db close];
    }


}


//查询
- (NSMutableArray *)getModelFromFMDB{

    
    
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        NSMutableArray *array = [NSMutableArray array];
        while ([rs next]) {
            Model *model = [[Model alloc] init];
            model.name = [rs stringForColumn:@"name"];
            [array addObject:model];
        }
        [db close];
        return array;
        
    }
    
    return nil;

}





@end
