//
//  TKClockworkStyle.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TKClockworkStyle : NSObject<NSCopying>

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIColor *primaryColor;
@property (nonatomic, strong, readonly) UIColor *accentColor;
@property (nonatomic, strong, readonly) UIColor *secondhandColor;

- (instancetype)initWithTitle:(NSString *)title primaryColor:(UIColor *)primaryColor accentColor:(UIColor *)accentColor secondhandColor:(UIColor *)secondhandColor;

@end
