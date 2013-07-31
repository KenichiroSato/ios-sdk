//
//  IRWebViewController.m
//  IRKit
//
//  Created by Masakazu Ohtsuka on 2013/07/10.
//  Copyright (c) 2013年 KAYAC Inc. All rights reserved.
//

#import "IRWebViewController.h"
#import "IRViewCustomizer.h"

@interface IRWebViewController ()

@property (nonatomic) UIWebView *webView;

@end

@implementation IRWebViewController

- (void)loadView {
    LOG_CURRENT_METHOD;
    CGRect frame = [[UIScreen mainScreen] bounds];
    LOG(@"frame: %@", NSStringFromCGRect(frame));
    UIView *view = [[UIView alloc] initWithFrame:frame];

    _webView = [[UIWebView alloc] initWithFrame:frame];
    _webView.dataDetectorTypes = UIDataDetectorTypeLink;
    _webView.allowsInlineMediaPlayback = YES;
    [view addSubview:_webView];
    if (_url) {
        self.url = _url; // loadRequest
    }
    
    self.view = view;
}

- (void)setUrl: (NSString*) url
{
    LOG( @"url: %@", url );
    _url = url;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [_webView loadRequest:req];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelButtonPressed:)];

    [IRViewCustomizer sharedInstance].viewDidLoad(self);
}

- (void)cancelButtonPressed:(id)sender {
    LOG_CURRENT_METHOD;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
