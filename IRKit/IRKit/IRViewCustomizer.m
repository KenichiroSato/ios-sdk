#import "IRViewCustomizer.h"
#import "IRNewSignalScene1ViewController.h"
#import "IRSignalNameEditViewController.h"
#import "IRNewPeripheralScene1ViewController.h"
#import "IRNewPeripheralScene2ViewController.h"
#import "IRPeripheralNameEditViewController.h"
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
        viewController.edgesForExtendedLayout = UIRectEdgeNone;

        if ([viewController isKindOfClass:[IRNewSignalScene1ViewController class]] ||
            [viewController isKindOfClass:[IRNewPeripheralScene1ViewController class]]) {
            // bar
            UINavigationBar *bar = viewController.navigationController.navigationBar;
            [IRViewCustomizer customizeNavigationBar:bar];

            // replace cancel button
            UIBarButtonItem *original = viewController.navigationItem.leftBarButtonItem;
            [IRViewCustomizer customizeCancelButton:original
                                  forViewController:viewController
                                     withImageNamed:@"icn_navibar_cancel"];
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
                                     withImageNamed:@"icn_navibar_back"];
        }
        else if ([viewController isKindOfClass:[IRPeripheralNameEditViewController class]] ||
                 [viewController isKindOfClass:[IRSignalNameEditViewController class]]) {
            // bar
            UINavigationBar *bar = viewController.navigationController.navigationBar;
            [IRViewCustomizer customizeNavigationBar:bar];

            // custom done button
//            UIBarButtonItem *original = viewController.navigationItem.rightBarButtonItem;
//
//            UIImage *inactiveImage = [IRHelper imageInResourceNamed:@"btn_navibar_disable"];
//            UIImage *activeImage   = [IRHelper imageInResourceNamed:@"btn_navibar"];
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            [button setTitle:@"Done" forState:UIControlStateNormal];
//            [button setTitleColor:[IRViewCustomizer textColor] forState:UIControlStateNormal];
//            [button setTitleColor:[IRViewCustomizer inactiveFontColor] forState:UIControlStateDisabled];
//            button.titleLabel.font = [UIFont fontWithName:@"Avenir-Light" size:12.];
//            [button setBackgroundImage:inactiveImage
//                              forState:UIControlStateDisabled];
//            [button setBackgroundImage:activeImage
//                              forState:UIControlStateNormal];
//            button.frame = (CGRect){ 0, 0, 45, 30 };
//            [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,0)]; // move the button **px right
//            [button addTarget:viewController
//                       action:original.action
//             forControlEvents:UIControlEventTouchUpInside];
//            UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
//
//            viewController.navigationItem.rightBarButtonItem = item;
        }
        // viewController.view.backgroundColor = [IRViewCustomizer defaultViewBackgroundColor];
    };


    return self;
}

// for navigationbar, normal text
+ (UIColor*) textColor {
    return [UIColor colorWithRed:0x33/255. green:0x33/255. blue:0x33/255. alpha:1.0];
}

// for buttons
+ (UIColor*) activeFontColor {
    return [UIColor colorWithRed:0x00/255. green:0xa8/255. blue:0xff/255. alpha:1.0];
}

+ (UIColor*) inactiveFontColor {
    return [UIColor colorWithRed:0x79/255. green:0x7a/255. blue:0x80/255. alpha:1.0];
}

+ (UIColor*) inactiveButtonBackgroundColor {
    return [UIColor colorWithRed:0x2b/255. green:0x2d/255. blue:0x33/255. alpha:1.0];
}

+ (UIColor*) activeButtonBackgroundColor {
    return [UIColor colorWithRed:0x00/255. green:0xcc/255. blue:0xcc/255. alpha:1.0];
}

+ (UIColor*) defaultViewBackgroundColor {
    return [UIColor colorWithRed:0x16/255. green:0x16/255. blue:0x1a/255. alpha:1.0];
}

+ (void)customizeCancelButton: (UIBarButtonItem*)original
            forViewController:(UIViewController*)viewController
               withImageNamed:(NSString*)name {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image   = [IRHelper imageInResourceNamed:name];
    [button setImage:image
            forState:UIControlStateNormal];
    [button sizeToFit];
    // [button setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-10)]; // move the button **px right
    [button addTarget:viewController
               action:original.action
     forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    viewController.navigationItem.leftBarButtonItem = item;
}

+ (void)customizeNavigationBar: (UINavigationBar*)bar {
    bar.barTintColor = [UIColor whiteColor];
    bar.tintColor = [self activeFontColor];
    // bar.translucent = NO; // if we don't want transparency

    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary: [[UINavigationBar appearance] titleTextAttributes]];
    [attributes setObject:[UIFont fontWithName:@"HelveticaNeue-Light" size:20.]
                   forKey:UITextAttributeFont ];
    [attributes setObject:[self textColor]
                   forKey:UITextAttributeTextColor];
    [bar setTitleTextAttributes: attributes];
}

@end
