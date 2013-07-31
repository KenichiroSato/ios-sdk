//
//  IRViewCustomizer.m
//  IRKit
//
//  Created by Masakazu Ohtsuka on 2013/07/31.
//  Copyright (c) 2013年 KAYAC Inc. All rights reserved.
//

#import "IRViewCustomizer.h"
#import "IRNewSignalScene1ViewController.h"
#import "IRNewPeripheralScene1ViewController.h"
#import "IRNewPeripheralScene2ViewController.h"
#import "IRNewPeripheralScene3ViewController.h"
#import "IRWebViewController.h"
#import "IRHelper.h"

@implementation IRViewCustomizer

+ (instancetype) sharedInstance {
    static IRViewCustomizer* instance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        instance = [[IRViewCustomizer alloc] init];
    });
    return instance;
}

- (id) init {
    self = [super init];
    if ( ! self ) {
        return nil;
    }

    _viewDidLoad = ^(UIViewController* viewController) {
        
        if ([viewController isKindOfClass:[IRNewSignalScene1ViewController class]] ||
            [viewController isKindOfClass:[IRNewPeripheralScene1ViewController class]]) {
            // bar
            UINavigationBar *bar = viewController.navigationController.navigationBar;
            [IRViewCustomizer customizeNavigationBar:bar];

            // replace cancel button
            UIBarButtonItem *original = viewController.navigationItem.leftBarButtonItem;
            [IRViewCustomizer customizeCancelButton:original
                                  forViewController:viewController
                                     withImageNamed:@"icn_actionbar_cancel"];
        }
        else if ([viewController isKindOfClass:[IRNewPeripheralScene2ViewController class]] ||
                 [viewController isKindOfClass:[IRWebViewController class]]) {
            // bar
            UINavigationBar *bar = viewController.navigationController.navigationBar;
            [IRViewCustomizer customizeNavigationBar:bar];

            // custom back button
            UIBarButtonItem *original = viewController.navigationItem.leftBarButtonItem;
            [IRViewCustomizer customizeCancelButton:original
                                  forViewController:viewController
                                     withImageNamed:@"icn_actionbar_back"];
        }
    };


    return self;
}

+ (void)leftBarButtonTouched:(id)sender {
    LOG_CURRENT_METHOD;
    
}

+ (void)customizeCancelButton: (UIBarButtonItem*)original forViewController:(UIViewController*)viewController withImageNamed:(NSString*)name {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[IRHelper imageInResourceNamed:name]
            forState:UIControlStateNormal];
    [button sizeToFit];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-10)]; // move the button **px right
    [button addTarget:viewController
               action:original.action
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    viewController.navigationItem.leftBarButtonItem = item;
}

+ (void)customizeNavigationBar: (UINavigationBar*)bar {
    [bar setBackgroundImage:[IRHelper imageWithColor:[UIColor colorWithRed:0x16/255. green:0x16/255. blue:0x1a/255. alpha:1.0]]
              forBarMetrics:UIBarMetricsDefault];

    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [attributes setObject:[UIFont fontWithName:@"Avenir-Light" size:20.]
                   forKey:UITextAttributeFont ];
    [bar setTitleTextAttributes: attributes];
}

@end
