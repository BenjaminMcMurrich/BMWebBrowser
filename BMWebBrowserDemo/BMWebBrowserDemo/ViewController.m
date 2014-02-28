//
//  ViewController.m
//  BMWebBrowserDemo
//
//  Created by Benjamin McMurrich on 28/02/14.
//  Copyright (c) 2014 mcmurrich.fr. All rights reserved.
//

#import "ViewController.h"
#import "BMWebBrowser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushToNavigation:(id)sender {
    NSURL * URL = [NSURL URLWithString:self.urlTextField.text];
    [self.navigationController pushViewController:[BMWebBrowser viewControllerWithURL:URL] animated:YES];
}

- (IBAction)presentModally:(id)sender {
    NSURL * URL = [NSURL URLWithString:self.urlTextField.text];
    [self presentViewController:[BMWebBrowser modalViewControllerWithURL:URL] animated:YES completion:nil];
}
@end
