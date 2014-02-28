//
//  ViewController.h
//  BMWebBrowserDemo
//
//  Created by Benjamin McMurrich on 28/02/14.
//  Copyright (c) 2014 mcmurrich.fr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;
- (IBAction)pushToNavigation:(id)sender;
- (IBAction)presentModally:(id)sender;
@end
