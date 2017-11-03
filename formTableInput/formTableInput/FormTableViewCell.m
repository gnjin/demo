//
//  FormTableViewCell.m
//  fast
//
//  Created by gaojian on 2017/9/21.
//  Copyright © 2017年 gaojian. All rights reserved.
//

#import "FormTableViewCell.h"

CGFloat kSpace = 5;
static NSString *const kContentSizeKey = @"contentSize";

static UITextView *inputView = nil;
static NSIndexPath *activeIndexPath = nil;
static UITableView *activeTableView = nil;

@interface FormTableViewCell () <UITextViewDelegate>
@end

@implementation FormTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _textInputView = [[UITextView alloc] initWithFrame:CGRectMake(kSpace, kSpace, CGRectGetWidth(self.bounds) - 2*kSpace, CGRectGetHeight(self.bounds) - 2*kSpace)];
        _textInputView.font = [[self class] contentFont];
        _textInputView.layer.borderColor = [UIColor grayColor].CGColor;
        _textInputView.layer.borderWidth = 0.8;
        _textInputView.delegate = self;
        [self.contentView addSubview:_textInputView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (UITextView *)inputView {
    
    if (!inputView) {
        
        inputView = [[UITextView alloc] initWithFrame:CGRectZero];
        inputView.font = [self contentFont];
        inputView.layer.borderColor = [UIColor grayColor].CGColor;
        inputView.layer.borderWidth = 0.8;
    }
    return inputView;
}

- (void)dealloc {
    
//    [[[self class] inputView] removeObserver:self forKeyPath:kContentSizeKey];
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:kContentSizeKey]) {
        
        UITextView *textView = (UITextView *)object;
        CGFloat newHeight = [change[NSKeyValueChangeNewKey] CGSizeValue].height;
        if (fabs(newHeight - textView.bounds.size.height) > 0.1) {
            
//            CGRect frame = textView.frame;
//            frame.size.height = newHeight > CGRectGetHeight(self.bounds) - 2*kSpace ? newHeight: CGRectGetHeight(self.bounds) - 2*kSpace;
//            textView.frame = frame;
            
            UITextView *input = [[self class] inputView];
            if (input == textView) {
                
                self.textInputView.text = input.text;
                self.itemHeightChange ? self.itemHeightChange(activeIndexPath, input) : 0;
            }
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = _textInputView.frame;
    frame.size.height = CGRectGetHeight(self.contentView.bounds) - 2*kSpace;
    _textInputView.frame = frame;
    
    if (activeTableView == self.tableView && activeIndexPath == [self.tableView indexPathForRowAtPoint:self.center]) {
        
        UITextView *input = [[self class] inputView];
        input.frame = [self.tableView convertRect:self.textInputView.bounds fromView:self.textInputView];
    }
}

#pragma mark- privateMehtod
+ (UIFont *)contentFont {
    
    return [UIFont systemFontOfSize:17];
}

#pragma mark- publicMehtod
- (CGFloat)cellHeight {
    
    CGFloat height = self.textInputView.contentSize.height + 2*kSpace;
    return height > kDefaultItemH ? height : kDefaultItemH;
}

#pragma mark- UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    UITextView *input = [[self class] inputView];
    if (input == textView) {
        return YES;
    }
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:self.center];
    if (!indexPath) {
        return NO;
    }
    activeIndexPath = indexPath;
    activeTableView = self.tableView;
    input.text = self.textInputView.text;
    input.frame = [self.tableView convertRect:self.textInputView.bounds fromView:self.textInputView];
    [input addObserver:self forKeyPath:kContentSizeKey options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    input.delegate = self;
    [self.tableView addSubview:input];
    if (![input isFirstResponder]) {
        [input becomeFirstResponder];
    }
    return NO;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    UITextView *input = [[self class] inputView];
    if (textView == input) {
        
        self.textInputView.text = input.text;
        [[[self class] inputView] removeObserver:self forKeyPath:kContentSizeKey];
        self.itemHeightChange ? self.itemHeightChange(activeIndexPath, input) : 0;
        [input removeFromSuperview];
        activeIndexPath = nil;
    }
}

@end
