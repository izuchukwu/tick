//
//  TKWeatherCache.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/22/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKWeatherCache.h"
#import "TKUserDefaults.h"

@implementation TKWeatherCache

#pragma mark - Weather Identifier Store

+ (void)weatherIDStoreWithCompletion:(void (^)(NSDictionary *store))completion {
    [TKUserDefaults objectForKey:TKUserDefaultsKeyUserWeatherIdentifierStore completion:^(id object) {
        completion(object);
    }];
}

+ (void)weatherIDForLocationID:(NSString *)locationID completion:(void (^)(NSString *weatherID))completion {
    [TKUserDefaults objectForKey:TKUserDefaultsKeyUserWeatherIdentifierStore completion:^(id object) {
        if (object) {
            completion([object objectForKey:locationID]);
        }
    }];
}

+ (void)setWeatherID:(NSString *)weatherID forLocationID:(NSString *)locationID {
    [TKUserDefaults objectForKey:TKUserDefaultsKeyUserWeatherIdentifierStore completion:^(id object) {
        if (object) {
            object = [NSMutableDictionary dictionaryWithDictionary:object];
        } else {
            object = [[NSMutableDictionary alloc] init];
        }
        
        [object setObject:weatherID forKey:locationID];
        [TKUserDefaults setObject:object forKey:TKUserDefaultsKeyUserWeatherIdentifierStore];
    }];
}

#pragma mark - Cache

+ (NSMutableDictionary *)forecastCache {
    static NSMutableDictionary *forecastCache = nil;
    if (!forecastCache) forecastCache = [[NSMutableDictionary alloc] init];
    return forecastCache;
}

+ (NSMutableDictionary *)currentConditionsCache {
    static NSMutableDictionary *currentConditionsCache = nil;
    if (!currentConditionsCache) currentConditionsCache = [[NSMutableDictionary alloc] init];
    return currentConditionsCache;
}

+ (NSMutableDictionary *)cacheExpiration {
    static NSMutableDictionary *cacheExpiration = nil;
    if (!cacheExpiration) cacheExpiration = [[NSMutableDictionary alloc] init];
    return cacheExpiration;
}

+ (NSURLSession *)session {
    static NSURLSession *session = nil;
    if (!session) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        //[sessionConfiguration setHTTPAdditionalHeaders:@{@"x-api-key":@""}];
        [sessionConfiguration setRequestCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [sessionConfiguration setURLCache:nil];
        session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        //
        session = [NSURLSession sharedSession];
    }
    return session;
}

#pragma mark - Fetching & Caching Consants

NSString *const TKWeatherCacheCurrentConditionsDidUpdateNotification = @"TKWeatherCacheCurrentConditionsDidUpdateNotification";

NSString *const TKWeatherCacheCacheExpirationForecastIDPrefixKey = @"cache-forecast-";
NSString *const TKWeatherCacheCacheExpirationCurrentConditionsKey = @"cache-current";

NSString *const TKWeatherCacheOpenWeatherMapAPIBase = @"http://api.openweathermap.org/data/2.5/";

NSString *const TKWeatherCacheOpenWeatherMapAPICurrentConditionsLatLonEndpointBase = @"weather?";
NSString *const TKWeatherCacheOpenWeatherMapAPICurrentConditionsIDEndpoint = @"group?id=";
NSString *const TKWeatherCacheOpenWeatherMapAPIForecastIDEndpoint = @"forecast?id=";

NSString *const TKWeatherCacheOpenWeatherMapAPICurrentConditionsLatLonEndpointParameterLatitude = @"lat=";
NSString *const TKWeatherCacheOpenWeatherMapAPICurrentConditionsLatLonEndpointParameterLongitude = @"&lon=";

NSString *const TKWeatherCacheOpenWeatherMapAPIUnitsParameterMetric = @"&units=metric";
NSString *const TKWeatherCacheOpenWeatherMapAPIUnitsParameterImperial = @"&units=imperial";

#pragma mark - Parsing Constants

// Common

NSString *const TKWeatherCacheDataCommonKeyLocationID = @"TKWeatherCacheDataCommonKeyLocationID";

NSString *const TKWeatherCacheDataCommonKeyConditionID = @"TKWeatherCacheDataCommonKeyConditionID";
NSString *const TKWeatherCacheDataCommonKeyConditionIconID = @"TKWeatherCacheDataCommonKeyConditionIconID";
NSString *const TKWeatherCacheDataCommonKeyConditionTitleFallback = @"TKWeatherCacheDataCommonKeyConditionTitleFallback";
NSString *const TKWeatherCacheDataCommonKeyConditionExtendedTitleFallback = @"TKWeatherCacheDataCommonKeyConditionExtendedTitleFallback";

NSString *const TKWeatherCacheDataCommonKeyTemperature = @"TKWeatherCacheDataCommonKeyTemperature";
NSString *const TKWeatherCacheDataCommonKeyTemperatureMax = @"TKWeatherCacheDataCommonKeyTemperatureMax";
NSString *const TKWeatherCacheDataCommonKeyTemperatureMin = @"TKWeatherCacheDataCommonKeyTemperatureMin";

NSString *const TKWeatherCacheDataCommonKeySunrise = @"TKWeatherCacheDataCommonKeySunrise";
NSString *const TKWeatherCacheDataCommonKeySunset = @"TKWeatherCacheDataCommonKeySunset";

// Forecast

NSString *const TKWeatherCacheDataForecastKeyConditionSet = @"TKWeatherCacheDataForecastKeyConditionSet";
NSString *const TKWeatherCacheDataForecastKeyForecastedTime = @"TKWeatherCacheDataForecastKeyForecastedTime";

// Common API

NSString *const TKWeatherCacheDataCommonAPIKeyLocationID = @"id";

NSString *const TKWeatherCacheDataCommonAPIKeyWeatherSet = @"weather";
NSString *const TKWeatherCacheDataCommonAPIKeyConditionID = @"id";
NSString *const TKWeatherCacheDataCommonAPIKeyConditionIconID = @"icon";
NSString *const TKWeatherCacheDataCommonAPIKeyConditionTitleFallback = @"main";
NSString *const TKWeatherCacheDataCommonAPIKeyConditionExtendedTitleFallback = @"description";

NSString *const TKWeatherCacheDataCommonAPIKeyMainSet = @"main";
NSString *const TKWeatherCacheDataCommonAPIKeyTemperature = @"temp";
NSString *const TKWeatherCacheDataCommonAPIKeyTemperatureMax = @"temp_max";
NSString *const TKWeatherCacheDataCommonAPIKeyTemperatureMin = @"temp_min";

NSString *const TKWeatherCacheDataCommonAPIKeySystemSet = @"sys";
NSString *const TKWeatherCacheDataCommonAPIKeySunrise = @"sunrise";
NSString *const TKWeatherCacheDataCommonAPIKeySunset = @"sunset";

// Group IDs API-Specific

NSString *const TKWeatherCacheDataGroupAPIKeyListSet = @"list";

// Forecast API-Specific

NSString *const TKWeatherCacheDataForecastAPIKeyCitySet = @"city";
NSString *const TKWeatherCacheDataForecastAPIKeyListSet = @"list";

NSString *const TKWeatherCacheDataForecastAPIKeyForecastedTime = @"dt";

#pragma mark - Requests

+ (void)requestCurrentConditionsDataWithLatitude:(double)latitude longitude:(double)longitude completion:(void (^)(NSDictionary *currentConditions))completion {
    NSString *latlonString = [NSString stringWithFormat:@"%@%@%f%@%f", TKWeatherCacheOpenWeatherMapAPICurrentConditionsLatLonEndpointBase, TKWeatherCacheOpenWeatherMapAPICurrentConditionsLatLonEndpointParameterLatitude, latitude, TKWeatherCacheOpenWeatherMapAPICurrentConditionsLatLonEndpointParameterLongitude, longitude];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", TKWeatherCacheOpenWeatherMapAPIBase, latlonString];
    
    BOOL isMetric = [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
    
    if (isMetric) {
        urlString = [urlString stringByAppendingString:TKWeatherCacheOpenWeatherMapAPIUnitsParameterMetric];
    } else {
        urlString = [urlString stringByAppendingString:TKWeatherCacheOpenWeatherMapAPIUnitsParameterImperial];
    }
    
    [self requestWeatherDataWithURL:[NSURL URLWithString:urlString] completion:^(NSDictionary *weatherData) {
        NSDictionary *weather = [self parseCurrentConditions:weatherData];
        self.currentConditionsCache[weather[TKWeatherCacheDataCommonKeyLocationID]] = weather;
        completion(weather);
    }];
}

+ (void)requestCurrentConditionsDataBatchWithIDs:(NSArray *)IDs completion:(void (^)(NSDictionary *))completion {
    NSString *IDsParameter = @"";
    
    for (NSString *ID in IDs) {
        IDsParameter = [NSString stringWithFormat:@"%@%@", IDsParameter, ID];
        if ([IDs lastObject] != ID) {
            IDsParameter = [IDsParameter stringByAppendingString:@","];
        }
    }
    
    NSString *IDsString = [NSString stringWithFormat:@"%@%@", TKWeatherCacheOpenWeatherMapAPICurrentConditionsIDEndpoint, IDsParameter];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", TKWeatherCacheOpenWeatherMapAPIBase, IDsString];
    
    BOOL isMetric = [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
    
    if (isMetric) {
        urlString = [urlString stringByAppendingString:TKWeatherCacheOpenWeatherMapAPIUnitsParameterMetric];
    } else {
        urlString = [urlString stringByAppendingString:TKWeatherCacheOpenWeatherMapAPIUnitsParameterImperial];
    }
    
    [self requestWeatherDataWithURL:[NSURL URLWithString:urlString] completion:^(NSDictionary *weatherData) {
        NSMutableDictionary *weatherSets = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *weatherSet in weatherData[TKWeatherCacheDataGroupAPIKeyListSet]) {
            NSDictionary *weather = [self parseCurrentConditions:weatherSet];
            weatherSets[weather[TKWeatherCacheDataCommonKeyLocationID]] = weather;
            self.currentConditionsCache[weather[TKWeatherCacheDataCommonKeyLocationID]] = weather;
        }
        
        completion(weatherSets);
    }];
}

+ (void)requestForecastDataWithID:(NSString *)ID completion:(void (^)(NSDictionary *))completion {
    NSString *forecastString = [NSString stringWithFormat:@"%@%@", TKWeatherCacheOpenWeatherMapAPIForecastIDEndpoint, ID];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", TKWeatherCacheOpenWeatherMapAPIBase, forecastString];
    
    BOOL isMetric = [[[NSLocale currentLocale] objectForKey:NSLocaleUsesMetricSystem] boolValue];
    
    if (isMetric) {
        urlString = [urlString stringByAppendingString:TKWeatherCacheOpenWeatherMapAPIUnitsParameterMetric];
    } else {
        urlString = [urlString stringByAppendingString:TKWeatherCacheOpenWeatherMapAPIUnitsParameterImperial];
    }
    
    [self requestWeatherDataWithURL:[NSURL URLWithString:urlString] completion:^(NSDictionary *weatherData) {
        NSDictionary *weather = [self parseForecast:weatherData];
        self.forecastCache[weather[TKWeatherCacheDataCommonKeyLocationID]] = weather;
        completion(weather);
    }];
}

#pragma mark - Parsing

+ (NSDictionary *)parseCurrentConditions:(NSDictionary *)weatherData {
    if (!weatherData) {
        return nil;
    }
    
    NSMutableDictionary *currentConditions = [[NSMutableDictionary alloc] init];
    
    currentConditions[TKWeatherCacheDataCommonKeyLocationID] = weatherData[TKWeatherCacheDataCommonAPIKeyLocationID];
    
    currentConditions[TKWeatherCacheDataCommonKeyConditionID] = [weatherData[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionID];
    currentConditions[TKWeatherCacheDataCommonKeyConditionIconID] = [weatherData[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionIconID];
    currentConditions[TKWeatherCacheDataCommonKeyConditionTitleFallback] = [weatherData[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionTitleFallback];
    currentConditions[TKWeatherCacheDataCommonKeyConditionExtendedTitleFallback] = [weatherData[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionExtendedTitleFallback];
    
    currentConditions[TKWeatherCacheDataCommonKeyTemperature] = weatherData[TKWeatherCacheDataCommonAPIKeyMainSet][TKWeatherCacheDataCommonAPIKeyTemperature];
    currentConditions[TKWeatherCacheDataCommonKeyTemperatureMax] = weatherData[TKWeatherCacheDataCommonAPIKeyMainSet][TKWeatherCacheDataCommonAPIKeyTemperatureMax];
    currentConditions[TKWeatherCacheDataCommonKeyTemperatureMin] = weatherData[TKWeatherCacheDataCommonAPIKeyMainSet][TKWeatherCacheDataCommonAPIKeyTemperatureMin];
    
    if (weatherData[TKWeatherCacheDataCommonAPIKeySystemSet][TKWeatherCacheDataCommonAPIKeySunrise]) {
        currentConditions[TKWeatherCacheDataCommonKeySunrise] = weatherData[TKWeatherCacheDataCommonAPIKeySystemSet][TKWeatherCacheDataCommonAPIKeySunrise];
    }
    
    if (weatherData[TKWeatherCacheDataCommonAPIKeySystemSet][TKWeatherCacheDataCommonAPIKeySunset]) {
        currentConditions[TKWeatherCacheDataCommonKeySunset] = weatherData[TKWeatherCacheDataCommonAPIKeySystemSet][TKWeatherCacheDataCommonAPIKeySunset];
    }
    
    return currentConditions;
}

+ (NSDictionary *)parseForecast:(NSDictionary *)weatherData {
    if (!weatherData) {
        return nil;
    }
    
    NSMutableDictionary *forecast = [[NSMutableDictionary alloc] init];
    
    forecast[TKWeatherCacheDataCommonKeyLocationID] = weatherData[TKWeatherCacheDataForecastAPIKeyCitySet][TKWeatherCacheDataCommonAPIKeyLocationID];
    
    NSArray *conditions = weatherData[TKWeatherCacheDataForecastAPIKeyListSet];
    NSMutableArray *parsedConditionSet = [[NSMutableArray alloc] init];
    
    for (NSDictionary *condition in conditions) {
        NSMutableDictionary *parsedCondition = [[NSMutableDictionary alloc] init];
        
        parsedCondition[TKWeatherCacheDataCommonKeyConditionID] = [condition[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionID];
        parsedCondition[TKWeatherCacheDataCommonKeyConditionIconID] = [condition[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionIconID];
        parsedCondition[TKWeatherCacheDataCommonKeyConditionTitleFallback] = [condition[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionIconID];
        parsedCondition[TKWeatherCacheDataCommonKeyConditionExtendedTitleFallback] = [condition[TKWeatherCacheDataCommonAPIKeyWeatherSet] firstObject][TKWeatherCacheDataCommonAPIKeyConditionExtendedTitleFallback];
        
        parsedCondition[TKWeatherCacheDataCommonKeyTemperature] = condition[TKWeatherCacheDataCommonAPIKeyMainSet][TKWeatherCacheDataCommonAPIKeyTemperature];
        parsedCondition[TKWeatherCacheDataCommonKeyTemperatureMax] = condition[TKWeatherCacheDataCommonAPIKeyMainSet][TKWeatherCacheDataCommonAPIKeyTemperatureMax];
        parsedCondition[TKWeatherCacheDataCommonKeyTemperatureMin] = condition[TKWeatherCacheDataCommonAPIKeyMainSet][TKWeatherCacheDataCommonAPIKeyTemperatureMin];
        
        parsedCondition[TKWeatherCacheDataForecastKeyForecastedTime] = condition[TKWeatherCacheDataForecastAPIKeyForecastedTime];
        
        [parsedConditionSet addObject:parsedCondition];
    }
    
    [forecast setObject:parsedConditionSet forKey:TKWeatherCacheDataForecastKeyConditionSet];
    
    return forecast;
}

#pragma mark - Network

+ (void)requestWeatherDataWithURL:(NSURL *)URL completion:(void (^)(NSDictionary *weatherData))completion {
    NSURLSessionDataTask *request = [self.session dataTaskWithURL:URL completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"[Error] Failed to download weather data\nRequest URL: %@\nError Description: %@", [URL absoluteString], [error description]);
        } else {
            error = nil;
            NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                NSLog(@"[Error] Failed to convert JSON Response\nRequest URL: %@\nError Description: %@", [URL absoluteString], [error description]);
            } else {
                completion(weatherData);
            }
        }
    }];
    [request resume];
}

@end
