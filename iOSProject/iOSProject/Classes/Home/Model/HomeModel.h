//
//  HomeModel.h
//
//  Created by BWF-HHW on 16/4/28.
//  Copyright © 2016年 BWF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface HomeModel : NSObject



@property (nonatomic, assign) CGFloat discount;

@property (nonatomic, copy) NSString *startTime;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *endTime;

@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *link;


@end
