//
//  TKClock.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TKTimepiece <NSObject>

- (void)clockDidTick:(id)sender;

@end

@interface TKClock : NSObject<NSCopying>

@property (nonatomic, weak) NSObject<TKTimepiece> *delegate;

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;
@property (nonatomic, readonly, strong) CLLocation *location;
@property (nonatomic, readonly, strong) NSTimeZone *timeZone;

- (instancetype)initWithLocationStoreIdentifier:(NSString *)identifier timeZoneIdentifier:(NSString *)timeZoneIdentifier title:(NSString *)title subtitle:(NSString *)subtitle location:(CLLocation *)location;

- (instancetype)initWithTimeZoneStoreIdentifier:(NSString *)identifier UTCOffset:(NSInteger)UTCOffset title:(NSString *)title subtitle:(NSString *)subtitle;

- (BOOL)isLocationAccurate;

@end
