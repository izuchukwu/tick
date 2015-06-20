//
//  AppDelegate.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TKClockwork.h"
#import "TKQuartz.h"

@interface TKAppDelegate : UIResponder <UIApplicationDelegate, TKClockworkAuthority>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TKClockwork *clockwork;
@property (strong, nonatomic) TKQuartz *quartz;

@end

