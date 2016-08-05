//
//  ViewController.m
//  iOSPush
//
//  Created by BWF-HHW on 16/8/4.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pushMessage:(id)sender {
    
    //初始化一个本地通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //触发通知时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    //重复间隔
    // localNotification.repeatInterval = kCFCalendarUnitMinute;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    //通知内容
    localNotification.alertBody = @"这是一条本地通知";
    //角标为1
    localNotification.applicationIconBadgeNumber = 1;
    //默认声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    //通知参数
    localNotification.userInfo = @{LocalNotificationKey: @"恭喜你, 本地通知已归你所有"};
    localNotification.category = NotificationCategoryIdent;
    //
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)cancelPush:(id)sender {
    
    for (UILocalNotification *obj in [UIApplication sharedApplication].scheduledLocalNotifications) {
        //遍历所有的本地通知, 当中可以依据key做相应的处理
        if ([obj.userInfo.allKeys containsObject:LocalNotificationKey]) {
            [[UIApplication sharedApplication] cancelLocalNotification:obj];
        }
    }
    //直接取消全部本地通知
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
