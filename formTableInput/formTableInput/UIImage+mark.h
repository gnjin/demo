//
//  UIImage+mark.h
//  formTableInput
//
//  Created by gaojian on 2017/11/8.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (mark)

- (UIImage *)imageMark:(NSString *)markString;
- (UIImage *)addText:(NSString *)text textAttributs:(NSDictionary *)attributes origin:(CGPoint)origin;
- (UIImage *)stretchImageWithLeftCapWidth:(NSInteger)leftCap topCapHeight:(NSInteger)topCap sLeftCapWidth:(NSInteger)sLeftCap sTopCapHeight:(NSInteger)sTopCap size:(CGSize)size;
@end
