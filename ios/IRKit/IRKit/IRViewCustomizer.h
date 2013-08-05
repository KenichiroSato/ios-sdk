//
//  IRViewCustomizer.h
//  IRKit
//
//  Created by Masakazu Ohtsuka on 2013/07/31.
//  Copyright (c) 2013年 KAYAC Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IRViewCustomizer : NSObject

// if set, viewDidLoad block will be called
// after any IRKit origin UIViewController's viewDidLoad:
// Set this callback if you want full control over
// IRKit's viewcontrollers appearance
// Otherwise you'll see IRKit's default appearance
@property (nonatomic, copy) void (^viewDidLoad)(UIViewController *viewController);

+ (instancetype) sharedInstance;

+ (UIColor*) activeFontColor;
+ (UIColor*) inactiveFontColor;

@end
