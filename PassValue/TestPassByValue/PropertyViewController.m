//
//  PropertyViewController.m
//  TestPassByValue
//
//  Created by BWF on  .
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "PropertyViewController.h"

#import "PropertyDetailViewController.h"

@interface PropertyViewController ()

- (IBAction)pressButton:(id)sender;

@end

@implementation PropertyViewController

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
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"属性传值";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"wifi" object:nil userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender
{
    PropertyDetailViewController *detailVC = [[PropertyDetailViewController alloc] init];
    //第三步：找到数据提供方，进行数据的赋值
    detailVC.passString = @"如果建筑工人像程序员写软件那样盖房子, 那第一只飞来的啄木鸟就能毁掉人类文明。";
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
