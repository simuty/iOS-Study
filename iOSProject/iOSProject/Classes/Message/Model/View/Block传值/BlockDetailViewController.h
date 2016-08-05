//
//  BlockDetailViewController.h
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import <UIKit/UIKit.h>

//第一步：声明block
typedef void (^PassValueBlock)(NSString* str);

@interface BlockDetailViewController : UIViewController

@property(nonatomic, copy) PassValueBlock block;

- (void)setHandlerBlock:(PassValueBlock) block;


@end
