//
//  CustomButton.m
//  BWFTabbar
//
//  Created by BWF-HHW on 16/6/14.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import "CustomButton.h"
#import "CYLPlusButtonSubclass.h"


@implementation CustomButton

+ (void)load {
    [super registerSubclass];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}


+ (instancetype)plusButton {
    CYLPlusButtonSubclass *button = [[CYLPlusButtonSubclass alloc] init];
    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


#pragma mark -
#pragma mark - Event Response

- (void)clickPublish {
    
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册选取", @"淘宝一键转卖", nil];
    [actionSheet showInView:viewController.view];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"buttonIndex = %@", @(buttonIndex));
}



#pragma mark - CYLPlusButtonSubclassing


+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 0;
}

+ (CGFloat)multiplerInCenterY {
    return  1;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
