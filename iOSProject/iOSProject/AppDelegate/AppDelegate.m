//
//  AppDelegate.m
//  iOSProject
//
//  Created by BWF-HHW on 16/8/4.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "AppDelegate.h"
#import "CYLTabBarControllerConfig.h"
#import "RootTabVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置主窗口,并设置根控制器
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //第一种形式
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init]
    ;
    [self.window setRootViewController:tabBarControllerConfig.tabBarController];
    
    //第二种形式
    //    RootTabVC *tabbarVC = [[RootTabVC alloc] init];
    //    [self.window setRootViewController:tabbarVC.tabBarController];
    
    
    [self.window makeKeyAndVisible];
    return YES;
    
}


- (void)wifi
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"有wifi" message:@"开始下片" delegate:nil cancelButtonTitle:@"无情的拒绝" otherButtonTitles:@"哈哈哈", nil];
    [alertView show];
}





@end
