//
//  AppDelegate.h
//  iOSDownload
//
//  Created by BWF-HHW on 16/8/17.
//  Copyright © 2016年 HHW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/* 用于保存后台下载任务完成后的回调代码块 */
@property (copy) void (^backgroundURLSessionCompletionHandler)();

@end

