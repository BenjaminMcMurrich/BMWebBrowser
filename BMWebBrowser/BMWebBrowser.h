//
//  BMWebBrowser.h
//
//  Created by Benjamin McMurrich on 29/01/14.
//  Copyright (c) 2014 Benjamin McMurrich. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
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
