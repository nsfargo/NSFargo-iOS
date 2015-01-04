//
//  EventMainViewController.h
//  NSFargo
//
//  Created by Bill Burgess on 1/3/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventMainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *eventTableView;
}

@end
