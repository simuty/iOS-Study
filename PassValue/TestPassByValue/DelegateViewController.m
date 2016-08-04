//
//  DelegateViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "DelegateViewController.h"

#import "DelegateDetailViewController.h"

//第五步：遵循代理协议
@interface DelegateViewController ()<DelegateDetailViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *aLabel;

- (IBAction)pressButton:(id)sender;

@end

@implementation DelegateViewController

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
    self.navigationItem.title = @"代理传值";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender
{
    DelegateDetailViewController *detailVC = [[DelegateDetailViewController alloc] init];
    //第四步：设置代理
    detailVC.delegate = self;
    [self.navigationController pushViewController:detailVC animated:YES];
}

//第六步：实现代理方法
#pragma mark - DelegateDetailViewControllerDelegate

- (void)passValue:(NSString *)passString
{
    //第七步，完成赋值
    self.aLabel.text = passString;
}

-(void)dealloc
{
//    [super dealloc];
//    detailVC.delegate = nil;
}

@end
