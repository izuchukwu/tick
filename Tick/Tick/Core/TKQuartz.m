//
//  TKQuartz.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKQuartz.h"

@interface TKQuartz ()

@property (nonatomic, strong) NSTimer *quartz;

@end

@implementation TKQuartz

NSString *const TKQuartzDidResonateNotification = @"TKQuartzDidResonateNotification";

- (void)beginResonation {
    [self endResonation];
    self.quartz = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(resonate) userInfo:nil repeats:YES];
}

- (void)resonate {
    [[NSNotificationCenter defaultCenter] postNotificationName:TKQuartzDidResonateNotification object:self];
}

- (void)endResonation {
    if (self.quartz) {
        [self.quartz invalidate];
    }
}

@end
