//
//  ExternViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "ExternViewController.h"

#import "ExternDetailViewController.h"

//第二步：引用外部变量
extern NSString *passString;

@interface ExternViewController ()

- (IBAction)pressButton:(id)sender;

@end

@implementation ExternViewController

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
    //第三步：为外部变量赋值
    passString = @"你写下的任何代码, 在六个月以后去看的话, 都像是别人写的。——Tom Cargill";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender
{
    ExternDetailViewController *detailVC = [[ExternDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
