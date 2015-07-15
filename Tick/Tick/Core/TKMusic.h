//
//  TKMusic.h
//  Tick
//
//  Created by Izuchukwu Elechi on 7/14/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@protocol TKMusicDelegate <NSObject>

- (void)musicDidUpdateWithNowPlayingInfo:(MPMediaItem *)nowPlayingInfo;

@end

@interface TKMusic : NSObject

@property (nonatomic, weak) id<TKMusicDelegate> delegate;

- (void)startListening;
- (void)stopListening;

@end
