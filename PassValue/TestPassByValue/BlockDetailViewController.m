//
//  BlockDetailViewController.m
//  TestPassByValue
//
//  Created by BWF on 14-8-13.
//  Copyright (c) 2016年 BWF. All rights reserved.
//

#import "BlockDetailViewController.h"

@interface BlockDetailViewController ()

@end

@implementation BlockDetailViewController

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //第一种写法, 不加判断如果其他类不调用会奔溃
//    NSString *passString = @"如果你把每一天都当作生命中最后一天去生活的话,那么有一天你会发现你是正确的！";
//    self.block(passString);
  

    //第二种写法
//    //第二步，回掉block
    if (self.block)
    {
    
        NSLog(@"1111111");
        NSString *passString = @"用代码行数测算软件开发进度如同按重量测算飞机的制造进度——比尔.盖茨)";
        self.block(passString);
    }
    

}
- (IBAction)retrunVC:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)setHandlerBlock:(PassValueBlock)block
{
    NSLog(@"2222222");
    self.block = block;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
