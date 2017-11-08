//
//  UIImage+mark.m
//  formTableInput
//
//  Created by gaojian on 2017/11/8.
//  Copyright © 2017年 gjian. All rights reserved.
//

#import "UIImage+mark.h"

@implementation UIImage (mark)

- (UIImage *)imageMark:(NSString *)markString fontSize:(CGFloat)foneSize {
    
    int w = self.size.width;
    int h = self.size.height;
    
    UIGraphicsBeginImageContext(self.size);
    
    [self drawInRect:CGRectMake(0, 0, w, h)];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor blackColor];
    shadow.shadowOffset = CGSizeMake(1, 1);
    
    NSDictionary *attr = @{
                           
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:foneSize],  //设置字体
                           
                           NSStrokeColorAttributeName : [UIColor whiteColor],   //设置字体颜色
                           
                           NSStrokeWidthAttributeName : @2,
                           
                           NSShadowAttributeName : shadow
                           };
    
    [markString drawInRect:CGRectMake(0, 0, w, h) withAttributes:attr];         //左上角
    
    //    [mark drawInRect:CGRectMake(w - , , , ) withAttributes:attr];      //右上角
    //
    //    [mark drawInRect:CGRectMake(w - , h - - , , ) withAttributes:attr];  //右下角
    //
    //    [mark drawInRect:CGRectMake(, h - - , , ) withAttributes:attr];    //左下角
    
    UIImage *markImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return markImage;
}

@end
