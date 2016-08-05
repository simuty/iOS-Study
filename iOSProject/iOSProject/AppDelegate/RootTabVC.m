//
//  RootTabVC.m
//  BWFTabbar
//
//  Created by BWF-HHW on 16/6/14.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import "RootTabVC.h"
#import "CYLTabBarController.h"


#import "HomeVC.h"
#import "MessageVC.h"
#import "MineVC.h"
#import "CYLSameCityViewController.h"

@interface RootTabVC()

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end


@implementation RootTabVC

- (CYLTabBarController *)tabBarController{

    if (_tabBarController == nil) {
        
        HomeVC *firstViewController = [[HomeVC alloc] init];
        UIViewController *firstNavigationController = [[UINavigationController alloc]
                                                       initWithRootViewController:firstViewController];
        
        
        CYLSameCityViewController *secondViewController = [[CYLSameCityViewController alloc] init];
        UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:secondViewController];
        
        
        

        
        CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
        [self customizeTabBarForController:tabBarController];
        
        [tabBarController setViewControllers:@[
                                               firstNavigationController,
                                               secondNavigationController
                                               ]];
        self.tabBarController = tabBarController;
        
    }
    
    return  _tabBarController;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_normal",
                            CYLTabBarItemSelectedImage : @"home_highlight",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"同城",
                            CYLTabBarItemImage : @"mycity_normal",
                            CYLTabBarItemSelectedImage : @"mycity_highlight",
                            };
    
   

    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}



@end
