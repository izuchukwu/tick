//
//  TKWeatherTests.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/22/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TKWeatherCache.h"

@interface TKWeatherTests : XCTestCase

@end

@implementation TKWeatherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCurrentConditionsFetch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Current Conditions Fetch Test"];
    
    float lat = 32.9656;
    float lon = -96.7158;
    
    [TKWeatherCache requestCurrentConditionsDataWithLatitude:lat longitude:lon completion:^(NSDictionary *results) {
        NSLog(@"current conditions for \"(%f,%f)\":\n%@", lat, lon, results);
        
        if (results) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:20.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
    
    //XCTAssert(YES, @"Pass");
}

- (void)testBatchCurrentConditionsFetch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Batch Current Conditions Fetch Test"];
    
    NSArray *IDs = @[@"524901",@"703448",@"2643743"];
    
    [TKWeatherCache requestCurrentConditionsDataBatchWithIDs:IDs completion:^(NSDictionary *results) {
        NSLog(@"current conditions for batch ID set \"%@\":\n%@", IDs, results);
        
        if (results) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:20.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
    
    //XCTAssert(YES, @"Pass");
}

- (void)testForecastFetch {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Forecast Fetch Test"];
    
    NSString *ID = @"2643743";
    
    [TKWeatherCache requestForecastDataWithID:ID completion:^(NSDictionary *results) {
        NSLog(@"forecast for batch ID set \"%@\":\n%@", ID, results);
        
        if (results) {
            [expectation fulfill];
        }
    }];
    
    [self waitForExpectationsWithTimeout:20.0 handler:^(NSError *error) {
        if(error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
    
    //XCTAssert(YES, @"Pass");
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
