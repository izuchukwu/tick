//
//  TKClockStoreTests.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "TKClockStore.h"

@interface TKClockStoreTests : XCTestCase

@property TKClockStore *clockStore;

@end

@implementation TKClockStoreTests

- (void)setUp {
    [super setUp];
    self.clockStore = [[TKClockStore alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

//- (void)testQuery {
//    NSString *query = @"toky";
//    XCTestExpectation *expectation = [self expectationWithDescription:@"Clock Store Query Test"];
//    
//    [self.clockStore queryPrimaryDiskStoresWithQuery:query completion:^(NSDictionary *results) {
//        NSLog(@"results for query \"%@\":\n%@", query, results);
//        
//        if (results) {
//            [expectation fulfill];
//        }
//    }];
//    
//    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
//        if(error) {
//            XCTFail(@"Expectation Failed with error: %@", error);
//        }
//    }];
//    
//    //XCTAssert(YES, @"Pass");
//}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
