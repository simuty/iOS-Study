//
//  DefaultViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "DefaultViewController.h"
#import "DefaultDetailViewController.h"

@interface DefaultViewController ()

- (IBAction)pressButton:(id)sender;

@end

@implementation DefaultViewController

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
    
    //第一步，利用NSUserDefaults保存数据
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];//获取单例
    NSString *string = @"在理论上, 理论和实践是没有差异的; 但在实践中, 是有的。In theory, there is no difference between theory and practice. But in practice, there is.——Snepscheut";
    [userDefaults setObject:string forKey:@"STRING"];//设置值
    [userDefaults synchronize];//写入文件
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender
{
    DefaultDetailViewController *detailVC = [[DefaultDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
