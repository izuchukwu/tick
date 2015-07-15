//
//  TKWeather.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKWeather.h"
#import "TKWeatherCache.h"
#import "TKWeatherQuartz.h"
#import "TKNotification.h"

@interface TKWeather ()

@property (nonatomic, copy) NSString *weatherIdentifier;

@end

@implementation TKWeather

- (instancetype)initWithLocation:(CLLocation *)location locationIdentifier:(NSString *)locationIdentifier delegate:(id<TKWeatherDelegate>)delegate {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [TKWeatherCache weatherIDForLocationID:locationIdentifier completion:^(NSString *weatherID) {
            if (weatherID) {
                self.weatherIdentifier = weatherID;
                [self commonInit];
            } else {
                [TKWeatherCache requestCurrentConditionsDataWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude completion:^(NSDictionary *results) {
                    [self currentConditionsDidUpdateWithWeatherData:results];
                    self.weatherIdentifier = results[TKWeatherCacheDataCommonKeyLocationID];
                    [TKWeatherCache setWeatherID:self.weatherIdentifier forLocationID:locationIdentifier];
                    [self commonInit];
                }];
            }
        }];
    }
    return self;
}

- (void)commonInit {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentConditionsDidUpdate:) name:TKWeatherQuartzNotificationKeyCurrentConditionsDidUpdate object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Weather Quartz Updates

- (void)currentConditionsDidUpdate:(NSNotification *)notification {
    NSDictionary *weather = [notification userInfo][self.weatherIdentifier];
    
    if (weather) {
        [self currentConditionsDidUpdateWithWeatherData:weather];
    }
}

- (void)currentConditionsDidUpdateWithWeatherData:(NSDictionary *)weatherData {
    self.currentConditions = weatherData;
    [self.delegate didUpdateWeather];
}

@end
