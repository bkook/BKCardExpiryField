//
//  BKViewController.h
//  BKCardExpiryFieldDemo
//
//  Created by Byungkook Jang on 2014. 7. 6..
//  Copyright (c) 2014년 Byungkook Jang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BKCardExpiryField.h"

@interface BKViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet BKCardExpiryField *cardExpiryField;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
