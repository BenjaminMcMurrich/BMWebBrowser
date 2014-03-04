//
//  BMBrowserViewController.m
//  LesDeferlantes
//
//  Created by Benjamin McMurrich on 29/01/14.
//  Copyright (c) 2014 Benjamin McMurrich. All rights reserved.
//

#import "BMWebBrowser.h"

enum actionSheetButtonIndex {
    kShareLinkButtonIndex,
	kSafariButtonIndex,
	kChromeButtonIndex,
};

@interface BMWebBrowser () {
    
    UILabel * titleLabel;
    UILabel * urlLabel;
    
    UIProgressView * progressView;
    BOOL theBool;
    NSTimer *timer;
    
    UIToolbar * toolBar;
    UIBarButtonItem *backButton;
    UIBarButtonItem *forwardButton;
    UIBarButtonItem * reloadButton;
}

@end

@implementation BMWebBrowser

+ (id)appearance
{
    return [MZAppearance appearanceForClass:[self class]];
}

+ (BMWebBrowser*) viewControllerWithURL:(NSURL*)URL {
    BMWebBrowser * webBrowser = [[BMWebBrowser alloc] initWithURL:URL];
    return webBrowser;
}

+(UINavigationController*) modalViewControllerWithURL:(NSURL*)url {
    
    BMWebBrowser * webBrowser = [[BMWebBrowser alloc] initWithURL:url];
    UINavigationController * navC = [[UINavigationController alloc] initWithRootViewController:webBrowser];
    
    webBrowser.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:webBrowser action:@selector(dismissModalViewController)];
    
    return navC;
}

-(void)dismissModalViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (id)initWithURL:(NSURL*)url {
    self = [self init];
    if(self)
    {
        self.url = url;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(buttonActionTouchUp:)];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    
    [self setDefaultSettings];
    [[[self class] appearance] applyInvocationTo:self];
    
    [self initTitleView];
    [self initProgressView];
    [self initToolBar];
    
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    
}

-(void) setDefaultSettings {
    self.urlLabelTextColor = [UIColor lightTextColor];
    self.progressViewTrackTintColor = [UIColor clearColor];
}

-(void) initTitleView {
    
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    titleView.backgroundColor = [UIColor clearColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, titleView.frame.size.width, 24)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [self.navigationController.navigationBar.titleTextAttributes objectForKey:NSForegroundColorAttributeName];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.text = NSLocalizedString(@"Loading...", @"");
    
    [titleView addSubview:titleLabel];
    
    urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, titleView.frame.size.width, 15)];
    urlLabel.backgroundColor = [UIColor clearColor];
    urlLabel.textColor = self.urlLabelTextColor;
    urlLabel.textAlignment = NSTextAlignmentCenter;
    urlLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    urlLabel.font = [UIFont systemFontOfSize:12];
    urlLabel.alpha = 0;
    
    [titleView addSubview:urlLabel];
    
    self.navigationItem.titleView = titleView;
}

-(void) initProgressView {
    
    progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 5)];
    progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    if(self.progressViewTintColor) progressView.tintColor = self.progressViewTintColor;
    progressView.trackTintColor = [UIColor clearColor];
    [self.view addSubview:progressView];
}

-(void) initToolBar {
    
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44)];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:toolBar];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 30;
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonTouchUp:)];
    forwardButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"forward"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(forwardButtonTouchUp:)];
    
    reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonTouchUp:)];

    [toolBar setItems:@[backButton,fixedSpace,forwardButton,flexibleSpace] animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) toggleBackForwardButtons {
    backButton.enabled = self.webView.canGoBack;
    forwardButton.enabled = self.webView.canGoForward;
    
    if(self.webView.canGoBack) {
        [UIView animateWithDuration:0.25
                         animations:^{
                             toolBar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
                         }
                         completion:^(BOOL finished) {
                             self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 44, 0);
                         }];
    }
}

#pragma mark - Actions

- (void)backButtonTouchUp:(id)sender {
    [self.webView goBack];
    [self toggleBackForwardButtons];
}

- (void)forwardButtonTouchUp:(id)sender {
    [self.webView goForward];
    [self toggleBackForwardButtons];
}

- (void)reloadButtonTouchUp:(id)sender {
    [self.webView reload];
    [self toggleBackForwardButtons];
}

- (void)buttonActionTouchUp:(id)sender {
    
    NSString *urlString = @"";
    NSURL* url = [self.webView.request URL];
    urlString = [url absoluteString];
    
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = urlString;
    actionSheet.delegate = self;
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Share link", nil)];
    [actionSheet addButtonWithTitle:NSLocalizedString(@"Open in Safari", nil)];
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]]) {
        // Chrome is installed, add the option to open in chrome.
        [actionSheet addButtonWithTitle:NSLocalizedString(@"Open in Chrome", nil)];
    }
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    
    if (self.navigationController.tabBarController != nil) {
        [actionSheet showFromTabBar:self.navigationController.tabBarController.tabBar];
    }
    else {
        [actionSheet showInView:self.view];
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == [actionSheet cancelButtonIndex]) return;
    
    NSURL *theURL = [self.webView.request URL];
    if (theURL == nil || [theURL isEqual:[NSURL URLWithString:@""]]) {
        theURL = self.url;
    }
    
    if (buttonIndex == kShareLinkButtonIndex) {
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                            initWithActivityItems:@[theURL]
                                                            applicationActivities:nil];
        
        [self presentViewController:activityViewController animated:YES completion:nil];
        
    } else if (buttonIndex == kSafariButtonIndex) {
        
        [[UIApplication sharedApplication] openURL:theURL];
    }
    else if (buttonIndex == kChromeButtonIndex) {
        NSString *scheme = theURL.scheme;
        
        // Replace the URL Scheme with the Chrome equivalent.
        NSString *chromeScheme = nil;
        if ([scheme isEqualToString:@"http"]) {
            chromeScheme = @"googlechrome";
        } else if ([scheme isEqualToString:@"https"]) {
            chromeScheme = @"googlechromes";
        }
        
        // Proceed only if a valid Google Chrome URI Scheme is available.
        if (chromeScheme) {
            NSString *absoluteString = [theURL absoluteString];
            NSRange rangeForScheme = [absoluteString rangeOfString:@":"];
            NSString *urlNoScheme = [absoluteString substringFromIndex:rangeForScheme.location];
            NSString *chromeURLString = [chromeScheme stringByAppendingString:urlNoScheme];
            NSURL *chromeURL = [NSURL URLWithString:chromeURLString];
            
            // Open the URL with Chrome.
            [[UIApplication sharedApplication] openURL:chromeURL];
        }
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([[request.URL absoluteString] hasPrefix:@"sms:"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
    if ([[request.URL absoluteString] hasPrefix:@"http://itunes.apple.com/"] ||
        [[request.URL absoluteString] hasPrefix:@"http://phobos.apple.com/"]) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
    urlLabel.text = [self urlStringToDisplayFromURL:request.URL];
    
    return YES;
}

-(NSString *) urlStringToDisplayFromURL:(NSURL*)URL {
    NSString * urlString = [URL absoluteString];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    urlString = [urlString stringByReplacingOccurrencesOfString:@"https://" withString:@""];
    if([urlString hasSuffix:@"/"]) urlString = [urlString substringToIndex:[urlString length]-1];
    return urlString;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self toggleBackForwardButtons];
    self.title = NSLocalizedString(@"Loading...", @"");
    

    [UIView animateWithDuration:0.25
                         animations:^{
                             titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, 2, titleLabel.frame.size.width, titleLabel.frame.size.height);
                             urlLabel.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                         }];

    
    progressView.hidden = FALSE;
    progressView.progress = 0;
    theBool = false;
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}

-(void)timerCallback {
    if (theBool) {
        if (progressView.progress >= 1) {
            [self dismissProgressView];
        }
        else {
            progressView.progress += 0.05;
        }
    }
    else {
        progressView.progress += 0.005;
        if (progressView.progress >= 0.85) {
            progressView.progress = 0.85;
        }
    }
}

-(void) dismissProgressView {
    [UIView animateWithDuration:0.25
                     animations:^{
                         progressView.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         progressView.hidden = true;
                         progressView.alpha = 1;
                     }];
    [timer invalidate];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString * title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    if([title length]>0) {
        self.title = title;
        titleLabel.text = title;
    }
    
    urlLabel.text = [self urlStringToDisplayFromURL:webView.request.URL];
    
    
    [self toggleBackForwardButtons];
    theBool = true;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    // To avoid getting an error alert when you click on a link
    // before a request has finished loading.
    if ([error code] == NSURLErrorCancelled) {
        return;
    }
    
    [self dismissProgressView];
    
    // Show error alert
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Impossible de charger la page", nil)
                                                    message:error.localizedDescription
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
	[alert show];
}

@end
