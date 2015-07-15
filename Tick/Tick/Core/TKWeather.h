//
//  TKWeather.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol TKWeatherDelegate <NSObject>

- (void)didUpdateWeather;

@end

@interface TKWeather : NSObject

@property (nonatomic, copy) NSDictionary *currentConditions;
@property (nonatomic, weak) id<TKWeatherDelegate> delegate;

- (instancetype)initWithLocation:(CLLocation *)location locationIdentifier:(NSString *)locationIdentifier delegate:(id<TKWeatherDelegate>)delegate;

@end
