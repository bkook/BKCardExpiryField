//
//  BKCardExpiryField.h
//  BKCardExpiryFieldDemo
//
//  Created by Byungkook Jang on 2014. 7. 6..
//  Copyright (c) 2014년 Byungkook Jang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKCardExpiryField : UITextField <UITextFieldDelegate>

@property (nonatomic, strong) NSDateComponents      *dateComponents;

@end
