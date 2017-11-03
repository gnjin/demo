//
//  FormTableViewCell.h
//  fast
//
//  Created by gaojian on 2017/9/21.
//  Copyright © 2017年 gaojian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FormTableViewCell;

typedef void(^FormItemChange)(NSIndexPath *, UITextView *);

static CGFloat const kDefaultItemH = 44;
extern CGFloat kSpace;

@interface FormTableViewCell : UITableViewCell

@property (class, strong, nonatomic, readonly) UITextView *inputView;
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UITextView *textInputView;
@property (copy, nonatomic) FormItemChange itemHeightChange;

- (CGFloat)cellHeight;

@end
