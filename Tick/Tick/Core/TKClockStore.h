//
//  TKClockStore.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKClockStore : NSObject

+ (void)userStoreWithCompletion:(void (^)(NSDictionary *results))completion;

- (void)queryPrimaryDiskStoresWithQuery:(NSString *)query completion:(void (^)(NSDictionary *results))completion;

- (void)purge;

@end
