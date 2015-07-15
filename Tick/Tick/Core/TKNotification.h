//
//  TKNotification.h
//  Tick
//
//  Created by Izuchukwu Elechi on 7/14/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TKNotification : NSObject

extern NSString *const TKNotificationCoreNotification;
extern NSString *const TKNotificationCoreNotificationUserInfoKey;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *tag;

@property (nonatomic, strong) NSDate *timestamp;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImage *activityIcon;

@end
