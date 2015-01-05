//
//  NSFDateFormatter.h
//  NSFargo
//
//  Created by Bill Burgess on 1/5/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFDateFormatter : NSObject

@property (strong, nonatomic) NSDateFormatter *eventFormatter;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

/**
 * gets singleton object.
 * @return singleton
 */
+ (instancetype)sharedManager;

+ (NSDate *)dateFromEventDateString:(NSString *)dateString;
+ (NSString *)dateStringFromEventDate:(NSDate *)date;
+ (NSString *)daysStringFromEventDate:(NSDate *)date;

@end
