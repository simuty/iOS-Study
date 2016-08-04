//
//  PropertyDetailViewController.h
//  TestPassByValue
//
//  Created by BWF on  .
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyDetailViewController : UIViewController

//第一步：确定数据接受方，声明属性
@property (nonatomic, retain) NSString *passString;

@end
