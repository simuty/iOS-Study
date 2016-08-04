//
//  DefaultDetailViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "DefaultDetailViewController.h"

@interface DefaultDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *aLabel;

@end

@implementation DefaultDetailViewController

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
    
    //第二步，利用NSUserDefaults获取值
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.aLabel.text = [userDefaults objectForKey:@"STRING"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
