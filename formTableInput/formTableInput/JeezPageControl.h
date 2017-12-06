//
//  JeezPageControl.h
//  HLCommunityPass
//
//  Created by gaojian on 2017/12/6.
//  Copyright © 2017年 qiushengsheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, JeezPageControlAlignment) {
    JeezPageControlAlignmentLeft = 1,
    JeezPageControlAlignmentCenter,
    JeezPageControlAlignmentRight
};

@interface JeezPageControl : UIControl

@property(nonatomic) NSInteger numberOfPages;
@property(nonatomic) NSInteger currentPage;

@property (nonatomic) JeezPageControlAlignment alignment;

@property(nullable, nonatomic,strong) UIColor *pageIndicatorTintColor UI_APPEARANCE_SELECTOR;
@property(nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor UI_APPEARANCE_SELECTOR;

- (void)widthToFit;

@end
