//
//  AppDelegate.h
//  NSFargo
//
//  Created by Bill Burgess on 1/3/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) IBOutlet UIWindow *window;
/// main tab bar controller for the application
@property (strong, nonatomic) UITabBarController *mainTabBarController;

@end

