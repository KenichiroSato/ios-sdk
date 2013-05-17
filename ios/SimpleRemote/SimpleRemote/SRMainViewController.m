//
//  SRMainViewController.m
//  SimpleRemote
//
//  Created by Masakazu Ohtsuka on 2013/05/17.
//  Copyright (c) 2013年 KAYAC Inc. All rights reserved.
//

#import "SRMainViewController.h"
#import "IRReceiveViewController.h"

@interface SRMainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBarButtonItem;

@end

@implementation SRMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)addBarButtonPressed:(id)sender {
    LOG_CURRENT_METHOD;
    
    IRReceiveViewController* receiver = [[IRReceiveViewController alloc] init];
    receiver.delegate = self;
    [self presentViewController:receiver animated:YES completion:^{
        LOG( @"presented" );
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
