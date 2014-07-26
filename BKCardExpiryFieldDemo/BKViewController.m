//
//  BKViewController.m
//  BKCardExpiryFieldDemo
//
//  Created by Byungkook Jang on 2014. 7. 6..
//  Copyright (c) 2014년 Byungkook Jang. All rights reserved.
//

#import "BKViewController.h"

@interface BKViewController ()

@end

@implementation BKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.cardExpiryField becomeFirstResponder];
    [self.cardExpiryField setDelegate:self];
    [self.cardExpiryField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
}

- (void)textFieldEditingChanged:(UITextField *)textField
{
    self.textView.text = self.cardExpiryField.dateComponents.description;
}


@end
