//
//  LLFScrollViewController.m
//  formTableInput
//
//  Created by gaojian on 2017/11/20.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import "LLFScrollViewController.h"

@interface LLFScrollViewController ()

@end

@implementation LLFScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addScrollView];
}

- (void)addScrollView {
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor blueColor];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIImage *image = [UIImage imageNamed:@"bg"];
    //    CGFloat top = (image.size.height -3) * 0.5; // 顶端盖高度
    //    CGFloat bottom = top ; // 底端盖高度
    //    CGFloat left = (image.size.width -3) * 0.5; // 左端盖宽度
    //    CGFloat right = left; // 右端盖宽度
    //    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    //    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(scrollView.bounds.size.width, scrollView.bounds.size.height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    scrollView.layer.contents = (__bridge id _Nullable)(newImage.CGImage);
    [self.view addSubview:scrollView];
    //    [self.view addSubview:imageView];
    
    CGFloat height = 45;
    UIView *testView = nil;
    for (NSInteger i = 0; i < 10; i++) {
        testView = [[UIView alloc] initWithFrame:CGRectMake(0, 2*i*height, CGRectGetWidth(scrollView.bounds), height)];
        testView.backgroundColor = [UIColor blueColor];
        [scrollView addSubview:testView];
    }
    scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(testView.frame));
}

@end
