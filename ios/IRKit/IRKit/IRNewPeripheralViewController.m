//
//  IRNewPeripheralViewController.m
//  IRKit
//
//  Created by Masakazu Ohtsuka on 2013/05/17.
//  Copyright (c) 2013年 KAYAC Inc. All rights reserved.
//

#import "IRNewPeripheralViewController.h"
#import "IRKit.h"

@interface IRNewPeripheralViewController ()

@property (nonatomic) UINavigationController *navController;

@property (nonatomic) id observer1;
@property (nonatomic) id observer2;

@end

@implementation IRNewPeripheralViewController

- (void)loadView {
    LOG_CURRENT_METHOD;
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIView *view = [[UIView alloc] initWithFrame:bounds];

    IRNewPeripheralScene1ViewController *first = [[IRNewPeripheralScene1ViewController alloc]init];
    first.delegate = self;
    _navController = [[UINavigationController alloc] initWithRootViewController:first];
    [view addSubview:_navController.view];

    self.view = view;
}

- (void)viewDidLoad {
    LOG_CURRENT_METHOD;
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    LOG_CURRENT_METHOD;
    [super viewWillAppear:animated];
    
    // hack http://stackoverflow.com/questions/5183834/uinavigationcontroller-within-viewcontroller-gap-at-top-of-view
    // prevent showing the weird 20px empty zone on top of navigationbar
    // when presented in caller's viewDidLoad
    [_navController setNavigationBarHidden:YES];
    [_navController setNavigationBarHidden:NO];
    
    _observer1 = [[NSNotificationCenter defaultCenter]
                 addObserverForName:IRKitDidConnectPeripheralNotification
                             object:nil
                              queue:[NSOperationQueue mainQueue]
                         usingBlock:^(NSNotification *note) {
                             LOG( @"new irkit connected");
                             IRNewPeripheralScene2ViewController *c =
                             [[IRNewPeripheralScene2ViewController alloc] init];
                             c.delegate = self;
                             [self.navController pushViewController:c
                                                            animated:YES];
                 }];
    
    _observer2 = [[NSNotificationCenter defaultCenter]
                 addObserverForName:IRKitDidAuthorizePeripheralNotification
                             object:nil
                              queue:[NSOperationQueue mainQueue]
                         usingBlock:^(NSNotification *note) {
                             LOG( @"irkit authorized");
                             IRNewPeripheralScene3ViewController *c = [[IRNewPeripheralScene3ViewController alloc] init];
                             c.delegate = self;
                             [self.navController pushViewController:c
                                                            animated:YES];
                 }];

}

- (void) viewWillDisappear:(BOOL)animated {
    LOG_CURRENT_METHOD;
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver: _observer1];
    [[NSNotificationCenter defaultCenter] removeObserver: _observer2];
}

- (void) viewDidAppear:(BOOL)animated {
    LOG_CURRENT_METHOD;
    [super viewDidAppear:animated];
}

- (void) dealloc {
    LOG_CURRENT_METHOD;
}

#pragma mark - UI events

- (void)didReceiveMemoryWarning
{
    LOG_CURRENT_METHOD;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IRNewPeripheralScene1ViewControllerDelegate

- (void)scene1ViewController:(IRNewPeripheralScene1ViewController *)viewController didFinishWithInfo:(NSDictionary*)info {
    LOG_CURRENT_METHOD;
    
    if ([info[IRViewControllerResultType] isEqualToString:IRViewControllerResultTypeCancelled]) {
        [self.delegate newPeripheralViewController:self
                                 didFinishWithInfo:@{
                        IRViewControllerResultType: IRViewControllerResultTypeCancelled
         }];
    }
    // shouldnt happen
}

#pragma mark - IRNewPeripheralScene2ViewControllerDelegate

- (void)scene2ViewController:(IRNewPeripheralScene2ViewController *)viewController didFinishWithInfo:(NSDictionary*)info {
    LOG_CURRENT_METHOD;
    
    if ([info[IRViewControllerResultType] isEqualToString:IRViewControllerResultTypeCancelled]) {
        [self.delegate newPeripheralViewController:self
                                 didFinishWithInfo:@{
                        IRViewControllerResultType: IRViewControllerResultTypeCancelled
         }];
    }
    // shouldnt happen
}

#pragma mark - IRNewPeripheralScene3ViewControllerDelegate

- (void)scene3ViewController:(IRNewPeripheralScene3ViewController *)viewController didFinishWithInfo:(NSDictionary*)info {
    LOG_CURRENT_METHOD;
    
    if ([info[IRViewControllerResultType] isEqualToString:IRViewControllerResultTypeDone]) {
        NSString *text = info[IRViewControllerResultText];
        IRPeripheral *peripheral = [[IRKit sharedInstance].peripherals objectAtIndex:0];
        peripheral.customizedName = text;
        [[IRKit sharedInstance] save];

        [self.delegate newPeripheralViewController:self
                                 didFinishWithInfo:@{
                IRViewControllerResultType: IRViewControllerResultTypeDone,
                IRViewControllerResultPeripheral: peripheral
         }];

    }
}

@end
