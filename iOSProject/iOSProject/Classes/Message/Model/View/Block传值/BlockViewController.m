//
//  BlockViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "BlockViewController.h"

#import "BlockDetailViewController.h"

@interface BlockViewController ()

@property (strong, nonatomic) IBOutlet UILabel *aLabel;

- (IBAction)pressButton:(id)sender;

@end

@implementation BlockViewController

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

- (IBAction)pressButton:(id)sender
{
    BlockDetailViewController *detailVC = [[BlockDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    //第三步，调用block
   NSLog(@"444444");

    [detailVC setHandlerBlock:^(NSString *str) {
        self.aLabel.text = str;
        NSLog(@"3333333");
    }];
    
    
    
}
@end
