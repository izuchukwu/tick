//
//  TKClockworkStyle.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKClockworkStyle.h"

@implementation TKClockworkStyle

- (instancetype)initWithTitle:(NSString *)title primaryColor:(UIColor *)primaryColor accentColor:(UIColor *)accentColor backgroundColor:(UIColor *)backgroundColor secondhandColor:(UIColor *)secondhandColor {
    self = [super init];
    if (self) {
        _title = title;
        _primaryColor = primaryColor;
        _accentColor = accentColor;
        _backgroundColor = backgroundColor;
        _secondhandColor = secondhandColor;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - Defaults

+ (NSArray *)defaults {
    return @[[self spaceGrayStyle], [self lightStyle], [self goldStyle]];
}

+ (TKClockworkStyle *)spaceGrayStyle {
    return [[TKClockworkStyle alloc] initWithTitle:@"Space Gray" primaryColor:[UIColor whiteColor] accentColor:[UIColor darkGrayColor] backgroundColor:[UIColor blackColor] secondhandColor:[UIColor redColor]];
}

+ (TKClockworkStyle *)lightStyle {
    return [[TKClockworkStyle alloc] initWithTitle:@"Space Gray" primaryColor:[UIColor darkGrayColor] accentColor:[UIColor whiteColor] backgroundColor:[UIColor whiteColor] secondhandColor:[UIColor redColor]];
}

+ (TKClockworkStyle *)goldStyle {
    return [[TKClockworkStyle alloc] initWithTitle:@"Space Gray" primaryColor:[UIColor darkGrayColor] accentColor:[UIColor yellowColor] backgroundColor:[UIColor whiteColor] secondhandColor:[UIColor darkGrayColor]];
}

@end
