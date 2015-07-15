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
    
    [self waitForExpectationsWithTimeout:60.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Test complete");
        }
    }];
}

- (void)musicDidUpdateWithNowPlayingInfo:(NSDictionary *)nowPlayingInfo {
    NSLog(@"Now Playing: %@", nowPlayingInfo);
}

@end
