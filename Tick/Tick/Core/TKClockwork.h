//
//  TKClockwork.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKClockworkStyle.h"

@protocol TKClockworkAuthority <NSObject>

// This protocol exists to verify who is permitted to restyle the application
// This is not enforced moreso than adding this protocol, but requires the conscience
//      decision to do so, and ease of finding all that have this property
// May be enforced by TKAppDelegate in future, or by class within the protocol

@end

@interface TKClockwork : NSObject

extern NSString *const TKClockworkStyleDidChangeNotification;
extern NSString *const TKClockworkStyleDidChangeNotificationContents;

@property (nonatomic, strong, readonly) TKClockworkStyle *currentStyle;

- (void)registerForNotifications:(NSObject *)styleable;
- (void)unregisterForNotifications:(NSObject *)styleable;

- (void)restyleApplicationWithAuthenticatedObject:(NSObject<TKClockworkAuthority> *)authenticatedObject style:(TKClockworkStyle *)style;

@end

@protocol TKClockworkStyleable <NSObject>

@property (nonatomic, weak) TKClockwork *clockwork;

- (void)restyle;

@end