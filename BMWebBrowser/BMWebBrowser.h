//
//  BMBrowserViewController.h
//  LesDeferlantes
//
//  Created by Benjamin McMurrich on 29/01/14.
//  Copyright (c) 2014 Benjamin McMurrich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMWebBrowser : UIViewController <UIWebViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSURL * url;

+ (BMWebBrowser*) viewControllerWithURL:(NSURL*)URL;
+ (UINavigationController*) modalViewControllerWithURL:(NSURL*)URL;

- (id)initWithURL:(NSURL*)url;


@end
