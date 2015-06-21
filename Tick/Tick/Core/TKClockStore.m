//
//  TKClockStore.m
//  Tick
//
//  Created by Izuchukwu Elechi on 6/20/15.
//  Copyright (c) 2015 Izuchukwu Elechi. All rights reserved.
//

#import "TKClockStore.h"
#import "TKUserDefaults.h"

@interface TKClockStore ()

@property (nonatomic, copy) NSArray *primaryLocationDiskStore;
@property (nonatomic, copy) NSArray *secondaryLocationDiskStore;

@property (nonatomic, copy) NSArray *primaryTimeZoneDiskStore;
@property (nonatomic, copy) NSArray *secondaryTimeZoneDiskStore;

@property (nonatomic, assign) NSTimeInterval lastDiskStoreAccessTimestamp;

@property (nonatomic, copy) NSDictionary *unitedStatesStateMapping;

@end

@implementation TKClockStore

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quartzDidResonate) name:nil object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - User Store

+ (void)userStoreWithCompletion:(void (^)(NSArray *userStore))completion {
    [TKUserDefaults objectForKey:TKUserDefaultsKeyUserClockStore completion:^(id object) {
        completion((NSArray *)object);
    }];
}

+ (void)addClockToUserStore:(TKClock *)clock {
    [self userStoreWithCompletion:^(NSArray *userStore) {
        [TKUserDefaults setObject:[userStore arrayByAddingObject:clock] forKey:TKUserDefaultsKeyUserClockStore];
    }];
}

#pragma mark - Clock Synthesis

+ (void)clockForClockData:(NSDictionary *)data completion:(void (^)(TKClock *clock))completion {
    NSString *identifier = data[@"key"];
    
    if ([identifier hasPrefix:@"LL"]) {
        TKClock *clock = [[TKClock alloc] initWithLocationStoreIdentifier:identifier timeZoneIdentifier:data[@"timezone"] title:data[@"title"] subtitle:data[@"subtitle"] location:[[CLLocation alloc] initWithLatitude:[data[@"lat"] floatValue] longitude:[data[@"lon"] floatValue]]];
        completion(clock);
    } else if ([identifier hasPrefix:@"TZ"]) {
        TKClock *clock = [[TKClock alloc] initWithTimeZoneStoreIdentifier:identifier UTCOffset:[data[@"offset"] intValue] title:data[@"title"] subtitle:data[@"subtitle"]];
        completion(clock);
    } else {
        NSLog(@"[Error] Clock request with invalid identifier prefix ignored");
        completion(nil);
    }
}

#pragma mark - Quartz

- (void)quartzDidResonate {
    NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval purgeInterval = self.lastDiskStoreAccessTimestamp + (5 * 60);
    
    if (now >= purgeInterval) {
        NSLog(@"Purging disk clock stores");
        [self purge];
    }
}

#pragma mark - Disk Query

- (void)queryPrimaryDiskStoresWithQuery:(NSString *)query completion:(void (^)(NSDictionary *results))completion {
    query = [query lowercaseString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *results = [[NSMutableDictionary alloc] init];
        
        NSPredicate *queryPredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            BOOL inTitle = [[evaluatedObject[@"title"] lowercaseString] rangeOfString:query].location != NSNotFound;
            BOOL inSubtitle = NO;
            if (evaluatedObject[@"subtitle"]) {
                inSubtitle = [[evaluatedObject[@"subtitle"] lowercaseString] rangeOfString:query].location != NSNotFound;
            }
            
            return inTitle || inSubtitle;
        }];
        
        results[@"locations"] = [self.primaryLocationDiskStore filteredArrayUsingPredicate:queryPredicate];
        results[@"timezones"] = [self.primaryTimeZoneDiskStore filteredArrayUsingPredicate:queryPredicate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(results);
        });
    });
}

#pragma mark - Locality

NSString *const TKClockStoreLocalityUnitedStatesStateMappingPlist = @"UnitedStatesStateLocalityMapping";
#define TKClockStoreLocalityUnitedKingdomCountryMapping @{@"ENG":@"ENGLAND", @"NIR":@"NORTHERN IRELAND", @"SCT":@"SCOTLAND", @"WLS":@"WALES"}

- (NSString *)locationSubtitleForData:(NSArray *)data {
    NSString *country = data[0];
    NSString *locality = data[1];
    
    if ([country isEqualToString:@"United States"] && ([locality length] == 2)) {
        // this is an American state abbreviation
        return [[self americanStateFullNameFromAbbreviation:locality] capitalizedStringWithLocale:[NSLocale currentLocale]];
    } else if ([country isEqualToString:@"United Kingdom"] && ([locality length] == 3)) {
        // this is a British country abbreviation
        return [[self britishCountryFullNameFromAbbreviation:locality] capitalizedStringWithLocale:[NSLocale currentLocale]];
    } else {
        // welp
        return country;
    }
}

- (NSString *)americanStateFullNameFromAbbreviation:(NSString *)abbreviation
{
    return self.unitedStatesStateMapping[[abbreviation uppercaseString]];
}

- (NSDictionary *)unitedStatesStateMapping {
    if (!_unitedStatesStateMapping) {
        NSDictionary *mapping = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStoreLocalityUnitedStatesStateMappingPlist ofType:@"plist"]];
        NSMutableDictionary *invertedMapping = [[NSMutableDictionary alloc] init];
        
        for (NSString *key in mapping) {
            invertedMapping[mapping[key]] = key;
        }
        
        _unitedStatesStateMapping = invertedMapping;
    }
    return _unitedStatesStateMapping;
}

- (NSString *)britishCountryFullNameFromAbbreviation:(NSString *)abbreviation {
    return [TKClockStoreLocalityUnitedKingdomCountryMapping[[abbreviation uppercaseString]] capitalizedString];
}

#pragma mark - Disk Store I/O

NSString *const TKClockStorePrimaryLocationKeysDiskStorePlist = @"PrimaryLocationKeysDiskStore";
NSString *const TKClockStoreSecondaryLocationKeysDiskStorePlist = @"SecondaryLocationKeysDiskStore";

NSString *const TKClockStorePrimaryLocationDataDiskStorePlist = @"PrimaryLocationDataDiskStore";
NSString *const TKClockStoreSecondaryLocationDataDiskStorePlist = @"SecondaryLocationDataDiskStore";

NSString *const TKClockStorePrimaryTimeZoneDiskStorePlist = @"PrimaryTimeZoneDiskStore";
NSString *const TKClockStoreSecondaryTimeZoneDiskStorePlist = @"SecondaryTimeZoneDiskStore";

- (NSArray *)primaryLocationDiskStore {
    if (!_primaryLocationDiskStore) {
        NSArray *locations = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStorePrimaryLocationKeysDiskStorePlist ofType:@"plist"]];
        NSMutableArray *locationStore = [[NSMutableArray alloc] init];
        
        for (NSString *location in locations) {
            NSArray *locationData = [location componentsSeparatedByString:@";"];
            NSDictionary *locationStoreItem = @{@"key":locationData[0]};
            [locationStore addObject:locationStoreItem];
        }
        
        _primaryLocationDiskStore = locationStore;
        _primaryLocationDiskStore = [self primaryLocationDataDiskStoreAugmentation];
    }
    
    self.lastDiskStoreAccessTimestamp = [[NSDate date] timeIntervalSince1970];
    
    return _primaryLocationDiskStore;
}

- (NSArray *)primaryLocationDataDiskStoreAugmentation {
    NSDictionary *locationData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStorePrimaryLocationDataDiskStorePlist ofType:@"plist"]];
    NSMutableArray *locationStore = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.primaryLocationDiskStore count]; i++) {
        NSDictionary *locationKeyStoreItem = self.primaryLocationDiskStore[i];
        NSString *locationKey = locationKeyStoreItem[@"key"];
        NSArray *locationItemData = locationData[locationKey];
        
        NSMutableDictionary *location = [NSMutableDictionary dictionaryWithDictionary:self.primaryLocationDiskStore[i]];
        location[@"title"] = locationItemData[1];
        
        NSString *subtitle = [self locationSubtitleForData:@[locationItemData[5], locationItemData[6]]];
        if (subtitle) location[@"subtitle"] = subtitle;
        
        location[@"key"] = [@"LL1-" stringByAppendingString:locationKey];
        
        // Extended Location-based Clock Data
        
        location[@"lat"] = locationItemData[3];
        location[@"lon"] = locationItemData[4];
        location[@"timezone"] = locationItemData[7];
        
        [locationStore addObject:[NSDictionary dictionaryWithDictionary:location]];
    }
    
    return locationStore;
}

- (NSArray *)secondaryLocationDiskStore {
    if (!_secondaryLocationDiskStore) {
        NSArray *locations = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStoreSecondaryLocationKeysDiskStorePlist ofType:@"plist"]];
        NSMutableArray *locationStore = [[NSMutableArray alloc] init];
        
        for (NSString *location in locations) {
            NSArray *locationData = [location componentsSeparatedByString:@";"];
            NSDictionary *locationStoreItem = @{@"key":locationData[0]};
            [locationStore addObject:locationStoreItem];
        }
        
        _secondaryLocationDiskStore = locationStore;
        _secondaryLocationDiskStore = [self secondaryLocationDataDiskStoreAugmentation];
    }
    
    self.lastDiskStoreAccessTimestamp = [[NSDate date] timeIntervalSince1970];
    
    return _secondaryLocationDiskStore;
}

- (NSArray *)secondaryLocationDataDiskStoreAugmentation {
    NSDictionary *locationData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStoreSecondaryLocationDataDiskStorePlist ofType:@"plist"]];
    NSMutableArray *locationStore = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.secondaryLocationDiskStore count]; i++) {
        NSDictionary *locationKeyStoreItem = self.secondaryLocationDiskStore[i];
        NSString *locationKey = locationKeyStoreItem[@"key"];
        NSArray *locationItemData = locationData[locationKey];
        
        NSMutableDictionary *location = [NSMutableDictionary dictionaryWithDictionary:self.secondaryLocationDiskStore[i]];
        location[@"title"] = locationItemData[1];
        
        NSString *subtitle = [self locationSubtitleForData:@[locationItemData[5], locationItemData[6]]];
        if (subtitle) location[@"subtitle"] = subtitle;
        
        location[@"key"] = [@"LL2-" stringByAppendingString:locationKey];
        
        // Extended Location-based Clock Data
        
        location[@"lat"] = locationItemData[3];
        location[@"lon"] = locationItemData[4];
        location[@"timezone"] = locationItemData[7];
        
        [locationStore addObject:[NSDictionary dictionaryWithDictionary:location]];
    }
    
    return locationStore;
}

- (NSArray *)primaryTimeZoneDiskStore {
    if (!_primaryTimeZoneDiskStore) {
        NSDictionary *timezones = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStorePrimaryTimeZoneDiskStorePlist ofType:@"plist"]];
        NSMutableArray *timezoneStore = [[NSMutableArray alloc] init];
        
        for (NSString *timezoneKey in timezones) {
            NSString *identifier = [@"TZ1-" stringByAppendingString:timezoneKey];
            
            // Note
            // The key "offset" counts as Extended Time Zone-based Clock Data
            
            NSDictionary *timezoneStoreItem = @{@"key":identifier, @"title":timezoneKey, @"subtitle":timezones[timezoneKey][0], @"offset":[NSString stringWithFormat:@"%d", [timezones[timezoneKey][2] intValue]]};
            
            [timezoneStore addObject:timezoneStoreItem];
        }
        
        _primaryTimeZoneDiskStore = [NSArray arrayWithArray:timezoneStore];
    }
    
    self.lastDiskStoreAccessTimestamp = [NSDate timeIntervalSinceReferenceDate];
    
    return _primaryTimeZoneDiskStore;
}

- (NSArray *)secondaryTimeZoneDiskStore {
    if (!_secondaryTimeZoneDiskStore) {
        NSDictionary *timezones = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:TKClockStoreSecondaryTimeZoneDiskStorePlist ofType:@"plist"]];
        NSMutableArray *timezoneStore = [[NSMutableArray alloc] init];
        
        for (NSString *timezoneKey in timezones) {
            NSString *identifier = [@"TZ2-" stringByAppendingString:timezoneKey];
            
            // Note
            // The key "offset" counts as Extended Time Zone-based Clock Data
            
            NSDictionary *timezoneStoreItem = @{@"key":identifier, @"title":timezoneKey, @"subtitle":timezones[timezoneKey][0], @"offset":[NSString stringWithFormat:@"%d", [timezones[timezoneKey][2] intValue]]};
            
            [timezoneStore addObject:timezoneStoreItem];
        }
        
        _secondaryTimeZoneDiskStore = [NSArray arrayWithArray:timezoneStore];
    }
    
    self.lastDiskStoreAccessTimestamp = [NSDate timeIntervalSinceReferenceDate];
    
    return _secondaryTimeZoneDiskStore;
}

- (void)purge {
    self.primaryLocationDiskStore = nil;
    self.secondaryLocationDiskStore = nil;
    
    self.primaryTimeZoneDiskStore = nil;
    self.secondaryTimeZoneDiskStore = nil;
    
    self.unitedStatesStateMapping = nil;
}

@end
