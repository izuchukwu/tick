//
//  TKNotification.m
//  Tick
//
//  Created by Izuchukwu Elechi on 7/14/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKNotification.h"

@implementation TKNotification

NSString *const TKNotificationCoreNotification = @"TKNotificationCoreNotification";
NSString *const TKNotificationCoreNotificationUserInfoKey = @"TKNotificationCoreNotificationUserInfoKey";

- (NSString *)description {
    NSMutableDictionary *description = [[NSMutableDictionary alloc] init];;
    
    if (self.title) {
        [description setObject:self.title forKey:@"title"];
    }
    
    if (self.subtitle) {
        [description setObject:self.subtitle forKey:@"subtitle"];
    }
    
    if (self.tag) {
        [description setObject:self.tag forKey:@"tag"];
    }
    
    if (self.timestamp) {
        [description setObject:self.timestamp forKey:@"timestamp"];
    }

    if (self.image) {
        [description setObject:self.image forKey:@"image"];
    }
    
    if (self.activityIcon) {
        [description setObject:self.activityIcon forKey:@"activityIcon"];
    }
    
    return [description description];
}

@end
