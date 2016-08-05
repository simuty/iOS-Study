//
//  PropertyDetailViewController.m
//  TestPassByValue
//
//  Created by BWF on  .
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "PropertyDetailViewController.h"

@interface PropertyDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *aLabel;

@end

@implementation PropertyDetailViewController

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
    self.navigationItem.title = @"属性传值详情";
    
    //第二步：明确生命周期，在合适的地方赋值
    self.aLabel.text = self.passString;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
