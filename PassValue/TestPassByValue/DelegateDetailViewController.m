//
//  DelegateDetailViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "DelegateDetailViewController.h"

@interface DelegateDetailViewController ()

@end

@implementation DelegateDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"代理传值详情";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([self.delegate respondsToSelector:@selector(passValue:)]) {
        //第三步：确定合适的实际调用代理方法
        [self.delegate passValue:@"如果调试(debug)是去除bug的过程, 那么编程就是制造bug的过程。"];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
