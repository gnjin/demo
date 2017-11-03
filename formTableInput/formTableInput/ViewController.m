//
//  ViewController.m
//  formTableInput
//
//  Created by gaojian on 2017/10/27.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import "ViewController.h"
#import "FormTableViewCell.h"

//static CGFloat const kDefaultItemH = 44;
static NSString *const kContentSizeKey = @"contentSize";
static NSString *const kFormCellReuseId = @"formCellReuseId";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *formTableView;
@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_formTableView registerClass:[FormTableViewCell class] forCellReuseIdentifier:kFormCellReuseId];
    _formTableView.tableFooterView = [UIView new];
    self.items = [@[@{@"content" : @""}, @{@"content" : @""}, @{@"content" : @""}] mutableCopy];
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *content = [self.items[indexPath.row] objectForKey:@"content"];
    FormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFormCellReuseId];
    if (!cell) {
        cell = [[FormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kFormCellReuseId];
    }
    cell.textInputView.text = content;
    return [cell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITextView *input = [FormTableViewCell inputView];
    if ([input isFirstResponder]) {
        [input resignFirstResponder];
    }
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kFormCellReuseId forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    cell.itemHeightChange = ^(NSIndexPath *changeIndexPath, UITextView *input) {
        
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return ;
        }
        
        NSArray *visibleIndexPaths = [strongSelf.formTableView indexPathsForVisibleRows];
        if (!changeIndexPath) {
            return;
        }
        [strongSelf.items replaceObjectAtIndex:changeIndexPath.row withObject:@{@"content" : input.text}];
        NSMutableArray *reloadIndexPaths = [[NSMutableArray alloc] init];
        for (NSIndexPath *visibleIndex in visibleIndexPaths) {
            
            if (visibleIndex >= changeIndexPath) {
                [reloadIndexPaths addObject:visibleIndex];
            }
        }
        [strongSelf.formTableView reloadRowsAtIndexPaths:reloadIndexPaths withRowAnimation:UITableViewRowAnimationNone];
    };
    cell.textInputView.text = [self.items[indexPath.row] objectForKey:@"content"];
    cell.tableView = tableView;
    return cell;
}

@end
