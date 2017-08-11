//
//  AppDelegate.m
//  iOSPush
//
//  Created by HHW-HHW on 16/8/4.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //注册本地通知
    [self registerLocationNotification: application];
    
    
    /**
     *  注册远程通知
     */
    //获取权限
    //        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge) categories:nil];
    //        [application registerUserNotificationSettings:setting];
    //        //注册远程通知
    //        [application registerForRemoteNotifications];
    //
    
    return YES;
}



/**
 *
 *  为了创建交互式通知，需要iOS 8提供的3个新类：UIUserNotificationSettings, UIUserNotificationCategory, UIUserNotificationAction 以及它们的变体。
 */
- (void)registerLocationNotification:(UIApplication *)application{
    
    
    //创建消息上面要添加的动作
    UIMutableUserNotificationAction *action1;
    action1 = [[UIMutableUserNotificationAction alloc] init];
    //当点击的时候不启动程序，在后台处理
    [action1 setActivationMode:UIUserNotificationActivationModeBackground];
    //按钮名称
    [action1 setTitle:@"按钮一"];
    [action1 setIdentifier:NotificationActionOneIdent];
    /*
     destructive属性设置后，在通知栏或锁屏界面左划，按钮颜色会变为红色
     如果两个按钮均设置为YES，则均为红色（略难看）
     如果两个按钮均设置为NO，即默认值，则第一个为蓝色，第二个为浅灰色
     如果一个YES一个NO，则都显示对应的颜色，即红蓝双色 (CP色)。
     */
    [action1 setDestructive:NO];
    //需要解锁才能处理(意思就是如果在锁屏界面收到通知，并且用户设置了屏幕锁，用户点击了赞不会直接进入我们的回调进行处理，而是需要用户输入屏幕锁密码之后才进入我们的回调)，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
    [action1 setAuthenticationRequired:NO];
    
    
    
    UIMutableUserNotificationAction *action2;
    action2 = [[UIMutableUserNotificationAction alloc] init];
    [action2 setActivationMode:UIUserNotificationActivationModeBackground];
    action2.identifier = NotificationActionTwoIdent;
    [action2 setTitle:@"评论"];
    //设置了behavior属性为 UIUserNotificationActionBehaviorTextInput 的话，则用户点击了该按钮会出现输入框供用户输入
    action2.behavior = UIUserNotificationActionBehaviorTextInput;
    //这个字典定义了当用户点击了评论按钮后，输入框右侧的按钮名称，如果不设置该字典，则右侧按钮名称默认为 “发送”
    action2.parameters = @{UIUserNotificationTextInputActionButtonTitleKey: @"评论"};
    
    
    /********************************************/
    
    ////创建动作(按钮)的类别集合
    UIMutableUserNotificationCategory *actionCategory;
    actionCategory = [[UIMutableUserNotificationCategory alloc] init];
    //这组动作的唯一标示
    [actionCategory setIdentifier:NotificationCategoryIdent];
    //添加动作
    [actionCategory setActions:@[action1, action2]
                    forContext:UIUserNotificationActionContextDefault];
    //集合中添加动作集合
    NSSet *categories = [NSSet setWithObject:actionCategory];
    
    /********************************************/
    
    //创建UIUserNotificationSettings，并设置消息的显示类类型
    UIUserNotificationSettings *sets = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:categories];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:sets];
    
    
}







// 本地通知回调函数，当应用程序在前台时调用
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"%@", notification.userInfo);
    [self showAlertView:@"用户没点击按钮直接点的推送消息进来的/或者该app在前台状态时收到推送消息"];
    NSInteger badge = [UIApplication sharedApplication].applicationIconBadgeNumber;
    badge -= notification.applicationIconBadgeNumber;
    badge = badge >= 0 ? badge : 0;
    [UIApplication sharedApplication].applicationIconBadgeNumber = badge;
}




//角标为0
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
}


//在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void(^)())completionHandler
{
    if ([identifier isEqualToString:NotificationActionOneIdent]) {
        [self showAlertView:@"点击了第一个按钮"];
    } else if ([identifier isEqualToString:NotificationActionTwoIdent]) {
        [self showAlertView:[NSString stringWithFormat:@"消息为:%@", responseInfo[UIUserNotificationActionResponseTypedTextKey]]];
    }
    
    completionHandler();
}


- (void)showAlertView:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self.window.rootViewController showDetailViewController:alert sender:nil];
}




/*********************远程推送相关*****************************/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //获取deviceToken，传给服务器
    NSLog(@"deviceToken:%@",deviceToken.description);
    
}


//收到的远程推送信息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    NSLog(@"userInfo----%@", userInfo);
    
}



@end
