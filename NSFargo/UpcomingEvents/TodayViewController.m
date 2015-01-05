//
//  TodayViewController.m
//  UpcomingEvents
//
//  Created by Bill Burgess on 1/3/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import "TodayViewController.h"
#import "NSFDateFormatter.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding> {
    NSMutableArray *upcomingEvents;
}

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"extension: viewDidLoad");
    
    upcomingEvents = [[NSMutableArray alloc] init];
    
    widgetTable.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"extension: viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"exension: viewDidAppear");
    
    // load events
    NSURL *eventsURL = [[NSBundle mainBundle] URLForResource:@"events" withExtension:@"json"];
    NSString *stringPath = [eventsURL absoluteString]; //this is correct
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"json: %@", json);
    
    upcomingEvents = [json[@"upcoming"] mutableCopy];
    [widgetTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"extension: viewWillDisappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGSize)preferredContentSize {
    return widgetTable.contentSize;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
    
    // load events
    NSURL *eventsURL = [[NSBundle mainBundle] URLForResource:@"events" withExtension:@"json"];
    NSString *stringPath = [eventsURL absoluteString]; //this is correct
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:stringPath]];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSLog(@"json: %@", json);
    
    upcomingEvents = [json[@"upcoming"] mutableCopy];
    [widgetTable reloadData];

    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

#pragma mark - UITableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.preferredContentSize = widgetTable.contentSize;
    return upcomingEvents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *event = upcomingEvents[indexPath.row];
    
    cell.textLabel.text = event[@"title"];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [NSFDateFormatter daysStringFromEventDate:[NSFDateFormatter dateFromEventDateString:event[@"date_time"]]];
    
    return cell;
}

@end
