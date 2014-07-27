//
//  BKCardExpiryField.m
//  BKCardExpiryFieldDemo
//
//  Created by Byungkook Jang on 2014. 7. 6..
//  Copyright (c) 2014년 Byungkook Jang. All rights reserved.
//

#import "BKCardExpiryField.h"

@interface BKCardExpiryField ()

@property (nonatomic, assign) id<UITextFieldDelegate>   customDelegate;
@property (nonatomic, strong) NSRegularExpression       *nonDigitRegularExpression;

@end

@implementation BKCardExpiryField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)_initialize
{
    [super setDelegate:self];
    
    self.placeholder = @"MM / YY";
    self.keyboardType = UIKeyboardTypeNumberPad;
    
    self.nonDigitRegularExpression = [[NSRegularExpression alloc] initWithPattern:@"[^0-9]+" options:0 error:nil];
}

- (void)dealloc
{
}

- (NSString *)numberOnlyStringWithString:(NSString *)string
{
    return [self.nonDigitRegularExpression stringByReplacingMatchesInString:string
                                                                    options:0
                                                                      range:NSMakeRange(0, string.length)
                                                               withTemplate:@""];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([self.customDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        if (NO == [self.customDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string]) {
            return NO;
        }
    }
    
    // always accepts delete key
    if (string.length == 0) {
        return YES;
    }
    
    NSString *replacedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *numberOnlyString = [self numberOnlyStringWithString:replacedString];
    
    if (numberOnlyString.length > 4) {
        return NO;
    }
    
    if (numberOnlyString.length == 1 && [numberOnlyString substringToIndex:1].integerValue > 1) {
        numberOnlyString = [@"0" stringByAppendingString:numberOnlyString];
    }
    
    NSMutableString *formattedString = [NSMutableString string];
    
    if (numberOnlyString.length > 0) {
        
        NSString *monthString = [numberOnlyString substringToIndex:MIN(2, numberOnlyString.length)];
        
        if (monthString.length == 2) {
            NSInteger monthInteger = monthString.integerValue;
            if (monthInteger < 1 || monthInteger > 12) {
                return NO;
            }
        }
        [formattedString appendString:monthString];
    }
    
    if (numberOnlyString.length > 1) {
        [formattedString appendString:@" / "];
    }
    
    if (numberOnlyString.length > 2) {
        NSString *yearString = [numberOnlyString substringFromIndex:2];
        [formattedString appendString:yearString];
    }

    [self setText:formattedString];
    
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    
    return NO;
}

+ (NSInteger)currentYear
{
    NSDateComponents *currentDateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
    return currentDateComponents.year;
}

- (NSDateComponents *)dateComponentsWithString:(NSString *)string
{
    NSString *numberString = [self numberOnlyStringWithString:string];
    
    NSDateComponents *result = [[NSDateComponents alloc] init];
    
    if (numberString.length > 1) {
        result.month = [[numberString substringToIndex:2] integerValue];
    }
    
    if (numberString.length > 3) {
        NSInteger currentYear = [[self class] currentYear];
        result.year = [[numberString substringFromIndex:2] integerValue] + (currentYear / 100 * 100);
    }
    
    return result;
}

#pragma mark - Public methods

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    _customDelegate = delegate;
}

- (NSDateComponents *)dateComponents
{
    return [self dateComponentsWithString:self.text];
}

- (void)setDateComponents:(NSDateComponents *)dateComponents
{
    [self setText:[NSString stringWithFormat:@"%02ld / %02ld", (long)dateComponents.month, (long)dateComponents.year % 100]];
}

#pragma mark - forward delegate methods

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([_customDelegate respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:_customDelegate];
    } else {
        [super forwardInvocation:anInvocation];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [_customDelegate respondsToSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (nil == signature) {
        signature = [(NSObject *)_customDelegate methodSignatureForSelector:aSelector];
    }
    return signature;
}

@end
