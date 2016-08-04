//
//  DelegateDetailViewController.h
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import <UIKit/UIKit.h>

//第一步，确定谁是数据的提供方，然后写协议
@protocol DelegateDetailViewControllerDelegate <NSObject>

- (void)passValue:(NSString *)passString;

@end

@interface DelegateDetailViewController : UIViewController

//第二步，声明Delegate，注意assign
@property (nonatomic, assign) id<DelegateDetailViewControllerDelegate> delegate;

@end
