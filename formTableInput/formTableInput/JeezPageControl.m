//
//  JeezPageControl.m
//  HLCommunityPass
//
//  Created by gaojian on 2017/12/6.
//  Copyright © 2017年 qiushengsheng. All rights reserved.
//

#import "JeezPageControl.h"

static const CGFloat kDotSize = 6;
static const CGFloat kDotSpacing = 8;
static const CGFloat kCurrentDotWidth = kDotSize * 1.8;

@interface JeezPageControl ()

@property (strong, nonatomic) NSArray *dotItems;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation JeezPageControl

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    
    _alignment = JeezPageControlAlignmentCenter;
    _pageIndicatorTintColor = [UIColor lightGrayColor];
    _currentPageIndicatorTintColor = [UIColor whiteColor];
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:_tapGesture];
    [self createDotView];
}

- (void)createDotView {
    
    for (UIView *dot in _dotItems) {
        [dot removeFromSuperview];
    }
    _dotItems = nil;
    
    NSMutableArray *dots = [NSMutableArray array];
    for (int i = 0; i < _numberOfPages; i++) {
        
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDotSize, kDotSize)];
        dotView.backgroundColor = _pageIndicatorTintColor;
        if (i == _currentPage) {
            dotView.frame = CGRectMake(0, 0, kCurrentDotWidth, kDotSize);
            dotView.backgroundColor = _currentPageIndicatorTintColor;
        }
        dotView.layer.cornerRadius = 0.5 * kDotSize;
        [self addSubview:dotView];
        [dots addObject:dotView];
    }
    _dotItems = dots;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    CGFloat contentWidth = _numberOfPages > 0 ? (_numberOfPages - 1) * kDotSize + kCurrentDotWidth + (_numberOfPages + 1) * kDotSpacing : 0;
    CGFloat origin_x = kDotSpacing;
    CGFloat origin_y = (selfHeight - kDotSize) * 0.5;
    switch (_alignment) {
        case JeezPageControlAlignmentLeft: {
        }break;
        case JeezPageControlAlignmentCenter: {
            origin_x += (selfWidth - contentWidth) * 0.5;
        }break;
        case JeezPageControlAlignmentRight: {
            origin_x += selfWidth - contentWidth;
        }break;
    }
    for (int i = 0; i < _numberOfPages; i++) {
        
        UIView *dotView = _dotItems[i];
        
        dotView.frame = CGRectMake(dotView.frame.origin.x, dotView.frame.origin.y, kDotSize, kDotSize);
        dotView.backgroundColor = _pageIndicatorTintColor;
        if (i == _currentPage) {
            dotView.frame = CGRectMake(dotView.frame.origin.x, dotView.frame.origin.y, kCurrentDotWidth, kDotSize);
            dotView.backgroundColor = _currentPageIndicatorTintColor;
        }
        
        dotView.frame = CGRectMake(origin_x, origin_y, CGRectGetWidth(dotView.bounds), CGRectGetHeight(dotView.bounds));
        origin_x += CGRectGetWidth(dotView.bounds) + kDotSpacing;
        dotView.hidden = origin_x < 0 || origin_x > selfWidth;
    }
}

#pragma mark- action
- (void)tapAction:(UIGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self];
    UIView *currentDotView = _dotItems[_currentPage];
    NSInteger page = _currentPage;
    if (CGRectGetMaxX(currentDotView.frame) < point.x) {
        page += 1;
        if (page > _dotItems.count - 1) return;
    }else if (CGRectGetMinX(currentDotView.frame) > point.x) {
        page -= 1;
        if (page < 0) return;
    }
    [self _setCurrentPage:page];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark- public
- (void)widthToFit {
    CGFloat width = _numberOfPages > 0 ? (_numberOfPages - 1) * kDotSize + kCurrentDotWidth + (_numberOfPages + 1) * kDotSpacing : 0;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.bounds.size.height);
}

#pragma mark- setter & getter
- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (numberOfPages < 0) numberOfPages = 0;
    if (_numberOfPages != numberOfPages) {
        _numberOfPages = numberOfPages;
        [self createDotView];
    }
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (currentPage > _dotItems.count - 1) return;
    if (currentPage < 0) currentPage = 0;
    if (_currentPage != currentPage) {
        [self _setCurrentPage:currentPage];
    }
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    if (_pageIndicatorTintColor != pageIndicatorTintColor) {
        [self _updateUI];
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    if (_currentPageIndicatorTintColor != currentPageIndicatorTintColor) {
        [self _updateUI];
    }
}

#pragma mark- private
- (void)_updateUI {
    for (int i = 0; i < _numberOfPages; i++) {
        UIView *dotView = _dotItems[i];
        dotView.backgroundColor = _pageIndicatorTintColor;
        if (i == _currentPage) {
            dotView.backgroundColor = _currentPageIndicatorTintColor;
        }
    }
}

- (void)_setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;
    [UIView animateWithDuration:0.3 animations:^{
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }];
}

@end
