//
//  UIImage+mark.m
//  formTableInput
//
//  Created by gaojian on 2017/11/8.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import "UIImage+mark.h"

static CGFloat kDefaultFontSize = 17;

@implementation UIImage (mark)

- (UIImage *)imageMark:(NSString *)markString {
    
    int w = self.size.width;
    int h = self.size.height;
    
    UIFont *textFont = [UIFont boldSystemFontOfSize:kDefaultFontSize];
    CGRect rect = [markString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName : textFont} context:nil];
    CGFloat fontSize = 0.8 * kDefaultFontSize * w / rect.size.width;
    textFont = [UIFont boldSystemFontOfSize:fontSize];
    CGFloat fontHeight = textFont.lineHeight;
    if (fontHeight > h * 0.2) {
        fontSize = fontSize * h * 0.2 / fontHeight;
    }
    textFont = [UIFont boldSystemFontOfSize:fontSize];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    
    NSDictionary *attr = @{
                           
                           NSFontAttributeName: textFont,  //设置字体
                           
                           NSStrokeColorAttributeName : [UIColor whiteColor],   //设置字体颜色
                           
                           NSStrokeWidthAttributeName : @2,
                           
                           NSShadowAttributeName : shadow
                           };
    rect = [markString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:0 attributes:@{NSFontAttributeName : textFont} context:nil];
    UIGraphicsBeginImageContext(rect.size);
    [markString drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height) withAttributes:attr];
    //    [mark drawInRect:CGRectMake(w - , , , ) withAttributes:attr];      //右上角
    //
    //    [mark drawInRect:CGRectMake(w - , h - - , , ) withAttributes:attr];  //右下角
    //
    //    [mark drawInRect:CGRectMake(, h - - , , ) withAttributes:attr];    //左下角
    UIImage *textImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, w, h)];
    
    CGContextRef con = UIGraphicsGetCurrentContext();
    
    CGContextRotateCTM(con, -30 * M_PI / 180.0);
    for (NSInteger i = 0; i < 3; i++) {
        
        [textImage drawAtPoint:CGPointMake(i * w * -0.13, i * h * 0.45)];
    }
    
    UIImage *markImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return markImage;
}

- (UIImage *)stretchImageWithLeftCapWidth:(NSInteger)leftCap topCapHeight:(NSInteger)topCap sLeftCapWidth:(NSInteger)sLeftCap sTopCapHeight:(NSInteger)sTopCap size:(CGSize)size {
    
    CGSize imageSize = self.size;
    UIImage *image = [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
    
    CGFloat tempWidth = size.width / 2 + imageSize.width / 2;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(tempWidth, size.height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, tempWidth, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    image = [image stretchableImageWithLeftCapWidth:sLeftCap + tempWidth - imageSize.width topCapHeight:sTopCap];
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, [UIScreen mainScreen].scale);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)addText:(NSString *)text textAttributs:(NSDictionary<NSAttributedStringKey, id> *)attributes origin:(CGPoint)origin {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.size.width, self.size.height), NO, self.scale);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [text drawAtPoint:CGPointMake(origin.x, origin.y) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
