//
//  TKUserDefaults.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/21/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKUserDefaults : NSObject

extern NSString *const TKUserDefaultsKeyUserClockStore;

+ (void)objectForKey:(NSString *)key completion:(void (^)(id object))completion;
+ (void)setObject:(id)object forKey:(NSString *)key;

@end
