//
//  TKClock.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "TKWeather.h"

@protocol TKTimepiece <NSObject>

- (void)clockDidTick:(id)sender;
- (void)weatherDidUpdate:(id)sender;

@end

@interface TKClock : NSObject<NSCopying, TKWeatherDelegate>

@property (nonatomic, weak) id<TKTimepiece> delegate;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly, strong) CLLocation *location;
@property (nonatomic, readonly, strong) NSTimeZone *timeZone;

- (instancetype)initWithLocationStoreIdentifier:(NSString *)identifier timeZoneIdentifier:(NSString *)timeZoneIdentifier title:(NSString *)title subtitle:(NSString *)subtitle location:(CLLocation *)location;
- (instancetype)initWithTimeZoneStoreIdentifier:(NSString *)identifier UTCOffset:(NSInteger)UTCOffset title:(NSString *)title subtitle:(NSString *)subtitle;

- (BOOL)isLocationAccurate;

- (NSDictionary *)currentConditionsData;

@end
