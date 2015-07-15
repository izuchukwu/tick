//
//  TKMusicTests.m
//  Tick
//
//  Created by Izuchukwu Elechi on 7/14/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TKMusic.h"
#import "TKNotification.h"

@interface TKMusicTests : XCTestCase<TKMusicDelegate>

@property (nonatomic, strong) XCTestExpectation *expectation;

@end

@implementation TKMusicTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMusic {
    self.expectation = [self expectationWithDescription:@"Music Test"];
    
    TKMusic *music = [[TKMusic alloc] init];
    [music setDelegate:self];
    [music startListening];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(musicDidUpdateWithNotification:) name:TKNotificationCoreNotification object:nil];
    
    [self waitForExpectationsWithTimeout:120.0 handler:nil];
}

#pragma mark - Notification

- (void)musicDidUpdateWithNotification:(NSNotification *)notification {
    NSLog(@"[Notification] Now Playing: %@", notification.userInfo[TKNotificationCoreNotificationUserInfoKey]);
}

#pragma mark - Delegate

- (void)musicDidUpdateWithNowPlayingInfo:(MPMediaItem *)nowPlayingInfo {
    NSLog(@"[Delegate] Now Playing: %@", nowPlayingInfo.title);
}

@end
