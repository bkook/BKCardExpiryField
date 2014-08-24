//
//  BKCardExpiryField.h
//  BKCardExpiryFieldDemo
//
//  Created by Byungkook Jang on 2014. 7. 6..
//  Copyright (c) 2014년 Byungkook Jang. All rights reserved.
//

#warning This library is deprecated and no longer maintained. Please use BKMoneyKit ( https://github.com/bkook/BKMoneyKit )

#import <UIKit/UIKit.h>

@interface BKCardExpiryField : UITextField <UITextFieldDelegate>

@property (nonatomic, strong) NSDateComponents      *dateComponents;

@end
