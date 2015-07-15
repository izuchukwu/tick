//
//  TKWeatherQuartz.h
//  Tick
//
//  Created by Izuchukwu Elechi on 7/13/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKWeatherQuartz : NSObject

extern NSString *const TKWeatherQuartzNotificationKeyCurrentConditionsDidUpdate;

@property (nonatomic, assign, readonly) BOOL isOnHold;

- (void)resume;
- (void)hold;

@end
