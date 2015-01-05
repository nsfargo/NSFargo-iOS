//
//  NSFDateFormatter.m
//  NSFargo
//
//  Created by Bill Burgess on 1/5/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import "NSFDateFormatter.h"
#import "NSDate+Escort.h"

@implementation NSFDateFormatter

+ (instancetype)sharedManager {
    
    static NSFDateFormatter *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

-(id) init {
    if (self = [super init]) {
        // initialize
        self.eventFormatter = [[NSDateFormatter alloc] init];
        [self.eventFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setLocale:[NSLocale currentLocale]];
        [self.dateFormatter setDateStyle:NSDateFormatterFullStyle];
        [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return self;
}

+ (NSDate *)dateFromEventDateString:(NSString *)dateString {
    NSFDateFormatter *formatter = [NSFDateFormatter sharedManager];
    return [formatter.eventFormatter dateFromString:dateString];
}

+ (NSString *)dateStringFromEventDate:(NSDate *)date {
    NSFDateFormatter *formatter = [NSFDateFormatter sharedManager];
    return [formatter.dateFormatter stringFromDate:date];
}

+ (NSString *)daysStringFromEventDate:(NSDate *)date {
    NSDate *today = [NSDate date];
    
    NSInteger daysUntil = [date daysAfterDate:today];
    
    NSString *unit;
    if (daysUntil == 0) {
        return NSLocalizedString(@"Today", @"Today");
    } else if (daysUntil == 1) {
        unit = NSLocalizedString(@"day", @"day");
    } else {
        unit = NSLocalizedString(@"days", @"days");
    }
    
    return [NSString stringWithFormat:@"%lu %@", daysUntil, unit];
}

@end
