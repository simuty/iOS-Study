//
//  SingletonDetailViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "SingletonDetailViewController.h"
#import "Singleton.h"

@interface SingletonDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *aLabel;

@end

@implementation SingletonDetailViewController

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
    
    //第五步：通过单例获取数据
    Singleton *singleton = [Singleton shareSingleton];
    self.aLabel.text = singleton.passString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
