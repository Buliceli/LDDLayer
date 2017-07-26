//
//  LDReplicatorAnimation.m
//  Layer层
//
//  Created by 李洞洞 on 26/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDReplicatorAnimation.h"

@implementation LDReplicatorAnimation
+ (CALayer *)replicatorLayerWithType:(ReplicatorLayerType)type
{
    CALayer *layer = nil;
    
    switch (type) {
        case LDReplicatorLayerCircle:
        {
            layer = [self replicatorLayer_Circle];
        }
            break;
        case LDReplicatorLayerWave:
        {
            layer = [self replicatorLayer_Wave];
        }
            break;
        case LDReplicatorLayerTriangle:
        {
            layer = [self replicatorLayer_Triangle];
        }
            break;
        case LDReplicatorLayerGrid:
        {
            layer = [self replicatorLayer_Grid];
        }
            break;
        case LDReplicatorLayerShake:
        {
            layer = [self replicatorLayer_Shake];
        }
            break;
        case LDReplicatorLayerRound:
        {
            layer = [self replicatorLayer_Round];
        }
            break;
        case LDReplicatorLayerHeart:
        {
            layer = [self replicatorLayer_Heart];
        }
            break;
        case LDReplicatorLayerTurn:
        {
            layer = [self replicatorLayer_Turn];
        }
            break;
        default:
        {
            layer = [self replicatorLayer_Circle];
        }
            break;
    }
    
    return layer;

}

// 波纹
+ (CALayer *)replicatorLayer_Circle
{
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, 80, 80);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 80, 80)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.opacity = 0.0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self alphaAnimation],[self scaleAnimation]];
    animationGroup.duration = 4.0;
    animationGroup.autoreverses = NO;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"animationGroup"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 80, 80);
    replicatorLayer.instanceDelay = 0.5;//每隔0.5出现一个layer
    replicatorLayer.instanceCount = 8;
    [replicatorLayer addSublayer:shape];
    return replicatorLayer;
}

// 波动
+ (CALayer *)replicatorLayer_Wave
{
    CGFloat between = 5.0;
    CGFloat radius = (100-2*between)/3;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, (100-radius)/2, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1].CGColor;
    [shape addAnimation:[self scaleAnimation1] forKey:@"scaleAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.5 - 40, [UIScreen mainScreen].bounds.size.height*0.5 - 40, 80, 80);
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceCount = 3;
    replicatorLayer.instanceTransform = CATransform3DMakeTranslation(between*2+radius,0,0);
    [replicatorLayer addSublayer:shape];
    
    return replicatorLayer;
}

// 三角形
+ (CALayer *)replicatorLayer_Triangle
{
    CGFloat radius = 100/4;
    CGFloat transX = 100 - radius;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.strokeColor = [UIColor redColor].CGColor;
    shape.fillColor = [UIColor redColor].CGColor;
    shape.lineWidth = 1;
    [shape addAnimation:[self rotationAnimation:transX] forKey:@"rotateAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.5 - radius, [UIScreen mainScreen].bounds.size.height*0.5 - radius, radius, radius);
    replicatorLayer.instanceDelay = 0.0;
    replicatorLayer.instanceCount = 3;
    CATransform3D trans3D = CATransform3DIdentity;
    trans3D = CATransform3DTranslate(trans3D, transX, 0, 0);
    trans3D = CATransform3DRotate(trans3D, 120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    replicatorLayer.instanceTransform = trans3D;
    [replicatorLayer addSublayer:shape];
    
    return replicatorLayer;
}

// 网格
+ (CALayer *)replicatorLayer_Grid
{
    NSInteger column = 3;
    CGFloat between = 5.0;
    CGFloat radius = (100 - between * (column - 1))/column;
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.frame = CGRectMake(0, 0, radius, radius);
    shape.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius, radius)].CGPath;
    shape.fillColor = [UIColor redColor].CGColor;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self scaleAnimation1], [self alphaAnimation]];
    animationGroup.duration = 1.0;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = HUGE;
    [shape addAnimation:animationGroup forKey:@"groupAnimation"];
    
    CAReplicatorLayer *replicatorLayerX = [CAReplicatorLayer layer];
    replicatorLayerX.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerX.instanceDelay = 0.3;
    replicatorLayerX.instanceCount = column;
    replicatorLayerX.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, radius+between, 0, 0);
    [replicatorLayerX addSublayer:shape];
    
    CAReplicatorLayer *replicatorLayerY = [CAReplicatorLayer layer];
    replicatorLayerY.frame = CGRectMake(0, 0, 100, 100);
    replicatorLayerY.instanceDelay = 0.3;
    replicatorLayerY.instanceCount = column;
    replicatorLayerY.instanceTransform = CATransform3DTranslate(CATransform3DIdentity, 0, radius+between, 0);
    [replicatorLayerY addSublayer:replicatorLayerX];
    
    return replicatorLayerY;

}

// 振动条
+ (CALayer *)replicatorLayer_Shake
{
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(0, 0, 10, 80);
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.anchorPoint = CGPointMake(0.5, 1);
    // 添加一个基本动画
    [layer addAnimation:[self scaleYAnimation] forKey:@"scaleAnimation"];
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake(0, 0, 80, 80);
    
    replicatorLayer.instanceCount = 6;
    replicatorLayer.instanceTransform =  CATransform3DMakeTranslation(45, 0, 0);
    replicatorLayer.instanceDelay = 0.2;
    replicatorLayer.instanceGreenOffset = -0.3;
    [replicatorLayer addSublayer:layer];
    return replicatorLayer;

}

// 转圈动画
+ (CALayer *)replicatorLayer_Round
{
    CALayer *layer = [[CALayer alloc]init];
    layer.frame = CGRectMake(0, 0, 12, 12);
    layer.cornerRadius = 6;
    layer.masksToBounds = YES;
    layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    layer.backgroundColor = [UIColor purpleColor].CGColor;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [layer addAnimation:animation forKey:nil];
    
    NSInteger instanceCount = 9;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*0.5 -25 ,[UIScreen mainScreen].bounds.size.height*0.5 -25, 50, 50);
    replicatorLayer.preservesDepth = YES;
    replicatorLayer.instanceColor = [UIColor whiteColor].CGColor;
    replicatorLayer.instanceRedOffset = 0.1;
    replicatorLayer.instanceGreenOffset = 0.1;
    replicatorLayer.instanceBlueOffset = 0.1;
    replicatorLayer.instanceAlphaOffset = 0.1;
    replicatorLayer.instanceCount = instanceCount;
    replicatorLayer.instanceDelay = 1.0/instanceCount;
    replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) /instanceCount, 0, 0, 1);
    [replicatorLayer addSublayer:layer];
    
    return replicatorLayer;
}

// 心动画
+ (CALayer *)replicatorLayer_Heart
{
    return nil;
}
+ (CALayer *)replicatorLayer_Turn
{
    return nil;
}
#pragma mark --------基础动画
+ (CABasicAnimation *)alphaAnimation{
    CABasicAnimation *alpha = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alpha.fromValue = @(1.0);
    alpha.toValue = @(0.0);
    return alpha;
}
+ (CABasicAnimation *)scaleAnimation{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    return scale;
}
+ (CABasicAnimation *)scaleAnimation1{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    scale.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.0)];
    scale.autoreverses = YES;
    scale.repeatCount = HUGE;
    scale.duration = 0.6;
    return scale;
}
+ (CABasicAnimation *)rotationAnimation:(CGFloat)transX{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform"];
    CATransform3D fromValue = CATransform3DRotate(CATransform3DIdentity, 0.0, 0.0, 0.0, 0.0);
    scale.fromValue = [NSValue valueWithCATransform3D:fromValue];
    
    CATransform3D toValue = CATransform3DTranslate(CATransform3DIdentity, transX, 0.0, 0.0);
    toValue = CATransform3DRotate(toValue,120.0*M_PI/180.0, 0.0, 0.0, 1.0);
    
    scale.toValue = [NSValue valueWithCATransform3D:toValue];
    scale.autoreverses = NO;
    scale.repeatCount = HUGE;
    scale.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scale.duration = 0.8;
    return scale;
}
+ (CABasicAnimation *)scaleYAnimation{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale.y"];
    anim.toValue = @0.1;
    anim.duration = 0.4;
    anim.autoreverses = YES;//往返都有动画
    anim.repeatCount = MAXFLOAT;//执行次数
    return anim;
}
@end
