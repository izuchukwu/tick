//
//  TKClockStore.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TKClock.h"

@interface TKClockStore : NSObject

+ (void)userStoreWithCompletion:(void (^)(NSArray *userStore))completion;
+ (void)addClockToUserStore:(TKClock *)clock;

- (void)queryPrimaryDiskStoresWithQuery:(NSString *)query completion:(void (^)(NSDictionary *results))completion;

- (void)purge;

@end
