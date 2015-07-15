//
//  TKMusic.m
//  Tick
//
//  Created by Izuchukwu Elechi on 7/14/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKMusic.h"

@implementation TKMusic

- (instancetype)init {
    self = [super init];
    if (self) {
        [[MPMusicPlayerController systemMusicPlayer] beginGeneratingPlaybackNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicDidChange) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[MPMusicPlayerController systemMusicPlayer] endGeneratingPlaybackNotifications];
}

- (void)musicDidChange {
    MPMediaItem *nowPlaying = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
    if (self.delegate) {
        [self.delegate musicDidUpdateWithNowPlayingInfo:nowPlaying];
    }
}

@end
