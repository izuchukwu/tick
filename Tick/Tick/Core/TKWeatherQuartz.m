//
//  TKWeatherQuartz.m
//  Tick
//
//  Created by Izuchukwu Elechi on 7/13/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKWeatherQuartz.h"
#import "TKWeatherCache.h"

@interface TKWeatherQuartz ()

@property (nonatomic, strong) NSTimer *quartz;

@end

@implementation TKWeatherQuartz

NSString *const TKWeatherQuartzNotificationKeyCurrentConditionsDidUpdate = @"TKWeatherQuartzNotificationKeyCurrentConditionsDidUpdate";

- (instancetype)init {
    self = [super init];
    if (self) {
        [self resume];
    }
    return self;
}

- (void)resume {
    if (!self.quartz) {
        self.quartz = [NSTimer timerWithTimeInterval:(15*60) target:self selector:@selector(quartzDidResonate) userInfo:nil repeats:YES];
    }
}

- (void)hold {
    if (self.quartz) {
        [self.quartz invalidate];
        self.quartz = nil;
    }
}

- (BOOL)isOnHold {
    return !self.quartz;
}

- (void)quartzDidResonate {
    [TKWeatherCache weatherIDStoreWithCompletion:^(NSDictionary *store) {
        if ([[store allKeys] count]) {
            NSMutableArray *identifiers = [[NSMutableArray alloc] init];
            for (NSString *locID in store) {
                [identifiers addObject:store[locID]];
            }
            
            [TKWeatherCache requestCurrentConditionsDataBatchWithIDs:identifiers completion:^(NSDictionary *results) {
                [[NSNotificationCenter defaultCenter] postNotificationName:TKWeatherQuartzNotificationKeyCurrentConditionsDidUpdate object:results];
            }];
        }
    }];
}

@end
