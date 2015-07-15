//
//  TKClockwork.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKClockwork.h"

@implementation TKClockwork

NSString *const TKClockworkStyleDidChangeNotification = @"TKClockworkStyleDidChangeNotification";
NSString *const TKClockworkStyleDidChangeNotificationContents = @"contents";

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Styling

- (void)restyleApplicationWithAuthenticatedObject:(NSObject<TKClockworkAuthority> *)authenticatedObject style:(TKClockworkStyle *)style {
    _currentStyle = style;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TKClockworkStyleDidChangeNotification object:self userInfo:@{TKClockworkStyleDidChangeNotificationContents:self.currentStyle}];
}

#pragma mark - Convenience

- (void)registerForNotifications:(NSObject *)styleable {
    [[NSNotificationCenter defaultCenter] addObserver:styleable selector:@selector(restyle) name:TKClockworkStyleDidChangeNotification object:nil];
}

- (void)unregisterForNotifications:(NSObject *)styleable {
    [[NSNotificationCenter defaultCenter] removeObserver:styleable];
}

@end
