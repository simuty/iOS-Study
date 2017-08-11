//
//  Model.m
//  RuntimeDemo
//
//  Created by BWF-HHW on 16/8/4.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "Model.h"


@interface Model()

@property (nonatomic, copy) NSString *sex;

@end

@implementation Model

- (instancetype)init{
    
    if ([super init]) {
        self.name = @"name";
        self.sex = @"man";
    }
    return self;
}

- (void)func1{
    NSLog(@"这个是函数一");
}

- (void)func2{
    NSLog(@"这个是函数二");
}



- (void)func3{
    NSLog(@"这个是函数三");
}


- (NSString *)description{
    return [NSString stringWithFormat:@"name---%@====sex====%@", self.name, self.sex];
}



@end
