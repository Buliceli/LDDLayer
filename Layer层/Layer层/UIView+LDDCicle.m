//
//  UIView+LDDCicle.m
//  Layer层
//
//  Created by 李洞洞 on 25/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "UIView+LDDCicle.h"

@implementation UIView (LDDCicle)
- (instancetype)cicleMaskView:(CGPoint)arcCenter radius:(CGFloat)radius
{
    UIBezierPath * bezierPath = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    self.layer.mask = shapeLayer;
    return self;
}
@end
