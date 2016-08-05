//
//  NotificationViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-19.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "NotificationViewController.h"
#import "NotificationDetailViewController.h"

@interface NotificationViewController ()

- (IBAction)pressButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *showLab;

@end

@implementation NotificationViewController

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
    
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"wifi" object:nil userInfo:nil];
    
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(done:) name:@"HHW" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

- (void)done:(NSNotification *)aNotification
{
    
    self.showLab.text = aNotification.object;
    NSLog(@"-------%@",aNotification.object);
//    NSLog(@"%s",__PRETTY_FUNCTION__);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"HHW" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender
{
    NotificationDetailViewController *detailVC = [[NotificationDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
