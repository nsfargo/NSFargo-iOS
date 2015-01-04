//
//  UIColor+NSFargo.m
//  NSFargo
//
//  Created by Bill Burgess on 1/3/15.
//  Copyright (c) 2015 NSFargo. All rights reserved.
//

#import "UIColor+NSFargo.h"

@implementation UIColor (NSFargo)

+ (UIColor *)NSFOrange {
    return [UIColor colorWithRed:241.0/255 green:90.0/255 blue:22.0/255 alpha:1.0f];
}

+ (UIColor *)NSFNavBarColor {
    return [UIColor NSFOrange];
}

@end
