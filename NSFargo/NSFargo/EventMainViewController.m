//
//  EventMainViewController.m
//  NSFargo
//
//  Created by Bill Burgess on 1/3/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import "EventMainViewController.h"

@interface EventMainViewController () {
    NSMutableArray *upcomingEvents;
    NSMutableArray *previousEvents;
}

@end

static NSDateFormatter *eventFormatter = nil;
static NSDateFormatter *dateFormatter = nil;

@implementation EventMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    eventFormatter = [[NSDateFormatter alloc] init];
    [eventFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZ"];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    // load events
    NSURL *eventsURL = [[NSBundle mainBundle] URLForResource:@"events" withExtension:@"json"];
    NSString *stringPath = [eventsURL absoluteString]; //this is correct
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"json: %@", json);
    
    upcomingEvents = [json[@"upcoming"] mutableCopy];
    previousEvents = [json[@"previous"] mutableCopy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return upcomingEvents.count;
    }
    if (section == 1) {
        return previousEvents.count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return NSLocalizedString(@"Upcoming", @"Upcoming");
    }
    if (section == 1) {
        return NSLocalizedString(@"Previous", @"Previous");
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        // upcoming events
        NSDictionary *event = upcomingEvents[indexPath.row];
        cell.textLabel.text = event[@"title"];
        NSDate *date = [eventFormatter dateFromString:event[@"date_time"]];
        cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    }
    
    if (indexPath.section == 1) {
        // previous events
        NSDictionary *event = previousEvents[indexPath.row];
        cell.textLabel.text = event[@"title"];
        NSDate *date = [eventFormatter dateFromString:event[@"date_time"]];
        cell.detailTextLabel.text = [dateFormatter stringFromDate:date];
    }
    
    return cell;
}

@end
