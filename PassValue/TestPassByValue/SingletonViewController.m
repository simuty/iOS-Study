//
//  SingletonViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "SingletonViewController.h"

#import "SingletonDetailViewController.h"
#import "Singleton.h"

@interface SingletonViewController ()

- (IBAction)pressButton:(id)sender;

@end

@implementation SingletonViewController

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
    
    //第四步：通过单例保存数据
    Singleton *singleton = [Singleton shareSingleton];
    singleton.passString = @"不要盲目地崇拜任何权威, 因为你总能找到相反的权威。——罗素 (哲学家 数学家 诺贝尔文学奖得主)";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender
{
    SingletonDetailViewController *detailVC = [[SingletonDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
