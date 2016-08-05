//
//  NotificationDetailViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-19.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "NotificationDetailViewController.h"

@interface NotificationDetailViewController ()
- (IBAction)post:(id)sender;

@end

@implementation NotificationDetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)post:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HHW" object:@"调试代码比新编写代码更困难。因此, 如果你尽自己所能写出了最复杂的代码, 你将没有更大的智慧去调试它。" userInfo:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
