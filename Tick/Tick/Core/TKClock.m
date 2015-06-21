//
//  TKClock.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKClock.h"
#import "TKQuartz.h"

@interface TKClock ()

@property (nonatomic, assign) NSTimeInterval reference;

@end

@implementation TKClock

@synthesize location = _location;

- (instancetype)initWithLocationStoreIdentifier:(NSString *)identifier timeZoneIdentifier:(NSString *)timeZoneIdentifier title:(NSString *)title subtitle:(NSString *)subtitle location:(CLLocation *)location {
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _location = location;
        _timeZone = [NSTimeZone timeZoneWithName:timeZoneIdentifier];
        
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithTimeZoneStoreIdentifier:(NSString *)identifier UTCOffset:(NSInteger)UTCOffset title:(NSString *)title subtitle:(NSString *)subtitle {
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subtitle;
        _timeZone = [NSTimeZone timeZoneForSecondsFromGMT:UTCOffset];
        
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.reference = [NSDate timeIntervalSinceReferenceDate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quartzDidResonate) name:TKQuartzDidResonateNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Quartz

- (void)quartzDidResonate {
    NSTimeInterval reference = self.reference;
    self.reference = [NSDate timeIntervalSinceReferenceDate];
    
    // Ensures delegate is only called when time has changed at the second level
    
    if (reference != [NSDate timeIntervalSinceReferenceDate]) {
        if (self.delegate) {
            [self.delegate clockDidTick:self];
        }
    }
}

#pragma mark - Location

- (CLLocation *)location {
    // Precise location provided for location-based clocks
    // Longitude approximation getter-generated for time zone-based clocks
    //   In this case, latitude will be set to the equator
    
    if (_location) {
        return _location;
    } else {
        NSInteger offsetSeconds = [self.timeZone secondsFromGMT];
        double offset = offsetSeconds / 60.0 / 60.0;
        CLLocationDegrees longitude = offset / 24.0 / 360.0;
        return [[CLLocation alloc] initWithLatitude:0 longitude:longitude];
    }
}

#pragma mark - Copying

- (id)copyWithZone:(NSZone *)zone {
    TKClock *clock = [[[self class] allocWithZone:zone] init];
    if (clock) {
        clock->_title = self.title;
        clock->_subtitle = self.subtitle;
        clock->_timeZone = self.timeZone;
        
        // locations are auto-generated in getter for timezone-based clocks
        // so use ivar to get true location value for copying
        
        clock->_location = _location;
    }
    return clock;
}

@end
