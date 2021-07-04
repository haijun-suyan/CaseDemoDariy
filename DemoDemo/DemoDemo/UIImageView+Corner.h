//
//  UIImageView+Corner.h
//  DemoDemo
//
//  Created by haijunyan on 2021/4/24.
//  Copyright © 2021 haijunyan. All rights reserved.
//

//移位枚举(映射移位值(或|逻辑))
typedef NS_OPTIONS(NSUInteger, UIRtCorner) {
    UIRtCornerTopLeft     = 1 << 0,
    UIRtCornerTopRight    = 1 << 1,
    UIRtCornerBottomLeft  = 1 << 2,
    UIRtCornerBottomRight = 1 << 3,
    UIRtCornerAllCorners  = ~0UL
};

#import <UIKit/UIKit.h>

@interface UIImageView (Corner)
//圆角效果优化
+ (void)imageViewCorner:(UIImageView *)imgV;
+ (void)imageViewCorner:(UIImageView *)imgV Corners:(UIRectCorner)corners;
//阴影效果优化
+ (void)shadowUI:(UIImageView *)imgV;
@end
