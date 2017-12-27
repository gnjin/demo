//
//  LLFScrollViewController.m
//  formTableInput
//
//  Created by gaojian on 2017/11/20.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import "LLFScrollViewController.h"
#import "UIImage+mark.h"

@interface LLFScrollViewController ()

@end

@implementation LLFScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self addScrollView];
    [self addAnnoImageView];
}

- (void)addAnnoImageView {
    
    NSString *tips = @"猜猜这是哪儿？";
    UIImage *annoImage = [UIImage imageNamed:@"map_anno"];
    
    UIFont *textFont = [UIFont systemFontOfSize:35];
    CGRect contentBounds = [tips boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 44) options:0 attributes:@{NSFontAttributeName : textFont} context:nil];
    CGSize defaultSize = CGSizeMake(186 / annoImage.scale, 104 / annoImage.scale);
    CGFloat width = contentBounds.size.width < defaultSize.width ? annoImage.size.width : contentBounds.size.width + annoImage.size.width - defaultSize.width;
    CGFloat height = contentBounds.size.height < defaultSize.height ? annoImage.size.height : contentBounds.size.height + annoImage.size.height - defaultSize.height;
    
    UIImage *newAnnoImage = [annoImage stretchImageWithLeftCapWidth:50 / annoImage.scale topCapHeight:50 / annoImage.scale sLeftCapWidth:200 / annoImage.scale sTopCapHeight:50 / annoImage.scale size:CGSizeMake(ceil(width), ceil(height))];
    
    CGPoint textOrigin = CGPointMake((newAnnoImage.size.width - contentBounds.size.width) * 0.5, 0);
    textOrigin.y = contentBounds.size.height < defaultSize.height ? (defaultSize.height - contentBounds.size.height) * 0.5 : (newAnnoImage.size.height - contentBounds.size.height) * 0.5;
    newAnnoImage = [newAnnoImage addText:tips textAttributs:@{NSFontAttributeName : textFont} origin:textOrigin];
    
    UIImageView *annoImageView = [[UIImageView alloc] initWithImage:newAnnoImage];
    annoImageView.frame = CGRectMake(20, 100, CGRectGetWidth(annoImageView.bounds), CGRectGetHeight(annoImageView.bounds));
    [self.view addSubview:annoImageView];
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
