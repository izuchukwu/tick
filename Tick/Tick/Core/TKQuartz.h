//
//  TKQuartz.h
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKQuartz : NSObject

extern NSString *const TKQuartzDidResonateNotification;

- (void)beginResonation;
- (void)endResonation;

@end
