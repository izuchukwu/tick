//
//  TKWeatherCache.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/22/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKWeatherCache : NSObject

+ (void)requestCurrentConditionsDataWithLatitude:(double)latitude longitude:(double)longitude completion:(void (^)(NSDictionary *results))completion;
+ (void)requestCurrentConditionsDataBatchWithIDs:(NSArray *)IDs completion:(void (^)(NSDictionary *results))completion;
+ (void)requestForecastDataWithID:(NSString *)ID completion:(void (^)(NSDictionary *results))completion;

// ID Conversion

+ (void)weatherIDStoreWithCompletion:(void (^)(NSDictionary *store))completion;
+ (void)weatherIDForLocationID:(NSString *)locationID completion:(void (^)(NSString *weatherID))completion;
+ (void)setWeatherID:(NSString *)weatherID forLocationID:(NSString *)locationID;

// Consts

extern NSString *const TKWeatherCacheDataCommonKeyLocationID;

extern NSString *const TKWeatherCacheDataCommonKeyConditionID;
extern NSString *const TKWeatherCacheDataCommonKeyConditionIconID;
extern NSString *const TKWeatherCacheDataCommonKeyConditionTitleFallback;
extern NSString *const TKWeatherCacheDataCommonKeyConditionExtendedTitleFallback;

extern NSString *const TKWeatherCacheDataCommonKeyTemperature;
extern NSString *const TKWeatherCacheDataCommonKeyTemperatureMax;
extern NSString *const TKWeatherCacheDataCommonKeyTemperatureMin;

extern NSString *const TKWeatherCacheDataCommonKeySunrise;
extern NSString *const TKWeatherCacheDataCommonKeySunset;

// Forecast

extern NSString *const TKWeatherCacheDataForecastKeyConditionSet;
extern NSString *const TKWeatherCacheDataForecastKeyForecastedTime;

@end
