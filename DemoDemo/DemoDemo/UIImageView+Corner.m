//
//  UIImageView+Corner.m
//  DemoDemo
//
//  Created by haijunyan on 2021/4/24.
//  Copyright © 2021 haijunyan. All rights reserved.
//  (CAShapeLayer+UIBezierPath组合)内存消耗更少渲染速度更快 > (CoreGraphics+UIBezierPath组合) > layer依赖层上下文环境
//  阴影效果优化shadow：主体层/依赖分层


#import "UIImageView+Corner.h"

@implementation UIImageView (Corner)

//(推荐GPU)采用CAShapeLayer和UIBezierPath组合绘制出圆角效果
+ (void)imageViewCorner:(UIImageView *)imgV Corners:(UIRectCorner)corners {
    //配置特定的限制体系下的某条曲线轨迹路径边界域
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imgV.bounds byRoundingCorners:corners cornerRadii:imgV.bounds.size];
    //形状图层(依赖分层)层级
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //形状图层研究的范围区域
    maskLayer.frame = imgV.bounds;
    //形状图层中待剪切的弧形区域的轨迹边界痕迹
    maskLayer.path = maskPath.CGPath;
    //带有轨迹边界痕迹的形状图层合成到目标图片内形成新的帧图渲染
    imgV.layer.mask = maskLayer;
}

//(不推荐CPU)贝塞尔曲线轨迹UIBezierPath和CoreGraphics组合绘制出圆角效果
+ (void)imageViewCorner:(UIImageView *)imgV {
    //通过曲线轨迹在目标矩形区域内进行轨迹线范围限制🚫(限制出弧度范围区)
    //激活待处理图片所在上下文环境进入绘制模式
    //size：目标矩形区域内 opaque：不透明性 scale：缩放比例
    UIGraphicsBeginImageContextWithOptions(imgV.bounds.size,NO,1.0);
    //正式用贝塞尔曲线轨迹(线)绘制出弧形图案边界域渲染(并沿着轨迹剪切出一片弧形区域)
    [[UIBezierPath bezierPathWithRoundedRect:imgV.bounds cornerRadius:imgV.frame.size.width] addClip];
    //剪切出的轨迹弧形区域内正式渲染帧图(存储在当前上下文环境的缓冲区内)
    [imgV drawRect:imgV.bounds];
    //从当前图片所在的上下文环境的缓冲区内读取合成后的图片数据信息(合成弧形帧图)(可**视)
    imgV.image = UIGraphicsGetImageFromCurrentImageContext();
    //退出待处理图片器皿所在上下文环境，结束绘制模式恢复常规模式
    UIGraphicsEndImageContext();
}

//bezierPathWithRect:描述依赖层所在区域的4元结构体值对应的形参rect字段表示的origin位置对应的数据参考值由layer依赖层的原点相对于对应主体层的原点之间的关系距离决定
+ (void)shadowUI:(UIImageView *)imgV {
    //layer依赖分层视觉效果特征设置
    imgV.layer.shadowColor = [UIColor grayColor].CGColor;
    imgV.layer.shadowOpacity = 1.0;
    imgV.layer.shadowRadius = 2.0;
    //配置限制体系的某条曲线轨迹路径边界域(阴影范围限制)
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:imgV.bounds];
    //根据轨迹边界痕迹的形状正式构建依赖层并合成到目标图片内形成新的帧图渲染
    imgV.layer.shadowPath = path.CGPath;
}

@end
