//
//  TKUserDefaults.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKUserDefaults.h"

@implementation TKUserDefaults

NSString *const TKUserDefaultsKeyUserClockStore = @"TKUserDefaultsKeyUserClockStore";
NSString *const TKUserDefaultsKeyUserWeatherIdentifierStore = @"TKUserDefaultsKeyUserWeatherIdentifierStore";

+ (void)objectForKey:(NSString *)key completion:(void (^)(id object))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id object = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(object);
        });
    });
}

+ (void)setObject:(id)object forKey:(NSString *)key {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    });
}

@end
