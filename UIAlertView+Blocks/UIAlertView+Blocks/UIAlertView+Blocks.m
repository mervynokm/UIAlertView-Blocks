//
//  UIAlertView+Blocks.m
//  UIAlertView+Blocks
//
//  Created by Mervyn Ong on 19/11/14.
//  Copyright (c) 2014 Mervyn Ong
//  The MIT License (MIT)
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import <objc/runtime.h>
#import "UIAlertView+Blocks.h"

static const char kAlertViewDelegate;
static const char kAlertViewCompletionBlock;
static const char kAlertViewWillPresentBlock;
static const char kAlertViewDidPresentBlock;
static const char kAlertViewWillDismissBlock;
static const char kAlertViewDidDismissBlock;

@implementation UIAlertView (Blocks)

#pragma mark - Public Class Methods

+(instancetype)showAlertViewWithCompletion:(AlertCompletionBlock)completionBlock
                                  forTitle:(NSString *)title
                                   message:(NSString *)message
                         cancelButtonTitle:(NSString *)cancelButtonTitle
                         otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title
                                                       message:message
                                                      delegate:nil
                                             cancelButtonTitle:cancelButtonTitle
                                             otherButtonTitles:nil];
    
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *arg = otherButtonTitles; arg != nil; arg = va_arg(args, NSString *)) {
        [alertView addButtonWithTitle:arg];
    }
    
    if(completionBlock){
        [alertView setCompletionBlock:completionBlock];
    }
    
    [alertView checkDelegate];
    [alertView show];
    return alertView;
}

#pragma mark - Setters and Getters

-(void)checkDelegate
{
    if (self.delegate != self) {
        objc_setAssociatedObject(self, &kAlertViewDelegate, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = self;
    }
}

-(AlertCompletionBlock)completionBlock
{
    return objc_getAssociatedObject(self, &kAlertViewCompletionBlock);
}

-(void)setCompletionBlock:(AlertCompletionBlock)completionBlock
{
    [self checkDelegate];
    objc_setAssociatedObject(self, &kAlertViewCompletionBlock, completionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(AlertBlock)willPresentBlock
{
    return objc_getAssociatedObject(self, &kAlertViewWillPresentBlock);
}

-(void)setWillPresentBlock:(AlertBlock)willPresentBlock
{
    [self checkDelegate];
    objc_setAssociatedObject(self, &kAlertViewWillPresentBlock, willPresentBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(AlertBlock)didPresentBlock
{
    return objc_getAssociatedObject(self, &kAlertViewDidPresentBlock);
}

-(void)setDidPresentBlock:(AlertBlock)didPresentBlock
{
    [self checkDelegate];
    objc_setAssociatedObject(self, &kAlertViewDidPresentBlock, didPresentBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(AlertCompletionBlock)willDismissBlock
{
    return objc_getAssociatedObject(self, &kAlertViewWillDismissBlock);
}

-(void)setWillDismissBlock:(AlertCompletionBlock)willDismissBlock
{
    [self checkDelegate];
    objc_setAssociatedObject(self, &kAlertViewWillDismissBlock, willDismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(AlertCompletionBlock)didDismissBlock
{
    return objc_getAssociatedObject(self, &kAlertViewDidDismissBlock);
}

-(void)setDidDismissBlock:(AlertCompletionBlock)didDismissBlock
{
    [self checkDelegate];
    objc_setAssociatedObject(self, &kAlertViewDidDismissBlock, didDismissBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.completionBlock) {
        alertView.completionBlock(alertView, buttonIndex);
    }
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    if (alertView.completionBlock) {
        alertView.completionBlock(alertView, alertView.cancelButtonIndex);
    }
}

-(void)willPresentAlertView:(UIAlertView *)alertView
{
    if (alertView.willPresentBlock) {
        alertView.willPresentBlock(alertView);
    }
}

-(void)didPresentAlertView:(UIAlertView *)alertView
{
    if (alertView.didPresentBlock) {
        alertView.didPresentBlock(alertView);
    }
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.willDismissBlock) {
        alertView.willDismissBlock(alertView, buttonIndex);
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.didDismissBlock) {
        alertView.didDismissBlock(alertView, buttonIndex);
    }
}

@end
