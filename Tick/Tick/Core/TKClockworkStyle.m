//
//  TKClockworkStyle.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKClockworkStyle.h"

@implementation TKClockworkStyle

- (instancetype)initWithTitle:(NSString *)title primaryColor:(UIColor *)primaryColor accentColor:(UIColor *)accentColor secondhandColor:(UIColor *)secondhandColor {
    self = [super init];
    if (self) {
        _title = title;
        _primaryColor = primaryColor;
        _accentColor = accentColor;
        _secondhandColor = secondhandColor;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

@end
