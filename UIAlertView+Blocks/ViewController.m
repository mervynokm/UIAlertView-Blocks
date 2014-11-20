//
//  ViewController.m
//  UIAlertView+Blocks
//
//  Created by Mervyn Ong on 19/11/14.
//  Copyright (c) 2014 Practice. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+Blocks.h"

@implementation ViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *callAlertButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [callAlertButton addTarget:self action:@selector(callAlert) forControlEvents:UIControlEventTouchUpInside];
    [callAlertButton setTitle:@"Alert" forState:UIControlStateNormal];
    callAlertButton.frame = CGRectMake(0, 0, 200, 100);
    callAlertButton.center = self.view.center;
    [self.view addSubview:callAlertButton];
}

-(void)callAlert
{
    UIAlertView *alertView = [UIAlertView showAlertViewWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
        NSLog(@"%ld", buttonIndex);
    }
                                                             forTitle:@"Title"
                                                              message:@"Message"
                                                    cancelButtonTitle:@"Cancel"
                                                    otherButtonTitles:@"One", @"Two", nil];
    
    alertView.willDismissBlock = ^(UIAlertView *alertView, NSInteger buttonIndex){
        NSLog(@"willDismissBlock");
    };
}

@end

