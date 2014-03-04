//
//  BMBrowserViewController.h
//  LesDeferlantes
//
//  Created by Benjamin McMurrich on 29/01/14.
//  Copyright (c) 2014 Benjamin McMurrich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZAppearance.h"

@interface BMWebBrowser : UIViewController <UIWebViewDelegate, UIActionSheetDelegate, MZAppearance>

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSURL * url;

@property (nonatomic,strong) UIColor *urlLabelTextColor MZ_APPEARANCE_SELECTOR;

@property (nonatomic,strong) UIColor *progressViewTintColor MZ_APPEARANCE_SELECTOR;
@property (nonatomic,strong) UIColor *progressViewTrackTintColor MZ_APPEARANCE_SELECTOR;

+ (id)appearance;

+ (BMWebBrowser*) viewControllerWithURL:(NSURL*)URL;
+ (UINavigationController*) modalViewControllerWithURL:(NSURL*)URL;

- (id)initWithURL:(NSURL*)url;


@end
