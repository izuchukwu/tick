//
//  TKMusic.m
//  Tick
//
//  Created by Izuchukwu Elechi on 7/14/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKMusic.h"
#import "TKNotification.h"

@interface TKMusic ()

@property (nonatomic, assign) BOOL didEnterBackground;
@property (nonatomic, assign) BOOL shouldIgnoreNextNotification;

@end

@implementation TKMusic

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopListening];
}

#pragma mark - Notifications

- (void)startListening {
    if ([[MPMusicPlayerController systemMusicPlayer] nowPlayingItem]) {
        self.shouldIgnoreNextNotification = YES;
    }
    
    [[MPMusicPlayerController systemMusicPlayer] beginGeneratingPlaybackNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicDidChange) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
}

- (void)stopListening {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:nil];
    [[MPMusicPlayerController systemMusicPlayer] endGeneratingPlaybackNotifications];
}

- (void)musicDidChange {
    if (self.shouldIgnoreNextNotification) {
        // This is to prevent the currently-playing track when this is called from triggering a notification
        
        self.shouldIgnoreNextNotification = NO;
        return;
    }
    
    MPMediaItem *nowPlaying = [[MPMusicPlayerController systemMusicPlayer] nowPlayingItem];
    if (self.delegate) {
        [self.delegate musicDidUpdateWithNowPlayingInfo:nowPlaying];
    }
    
    TKNotification *notification = [[TKNotification alloc] init];
    [notification setTitle:nowPlaying.title];
    [notification setSubtitle:nowPlaying.artist];
    [notification setTag:NSLocalizedString(@"Now Playing", @"Tag for Now Playing Core Notification")];
    [notification setImage:[nowPlaying.artwork imageWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.height)]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TKNotificationCoreNotification object:nil userInfo:@{TKNotificationCoreNotificationUserInfoKey:notification}];
}

- (void)applicationWillResignActive {
    [self stopListening];
    self.didEnterBackground = YES;
}

- (void)applicationDidBecomeActive {
    if (self.didEnterBackground) {
        [self startListening];
        
        // If we didn't do this, stopping listening when resigning active
        // then resuming listening when becoming active would always ignore the
        // immediately following notification
        self.shouldIgnoreNextNotification = NO;
        
        self.didEnterBackground = NO;
    }
}

@end
