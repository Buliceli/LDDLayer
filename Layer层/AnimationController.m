//
//  AnimationController.m
//  Layer层
//
//  Created by 李洞洞 on 25/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//
/**
 CAAnimation是所有动画的父类实现CAMediaTiming协议负责控制动画的时间、速度和时间曲线等等，是一个抽象类，不能直接使用。
 CAPropertyAnimation 是CAAniamtion的子类,它支持动画显示图层的keyPath一般不直接使用
 iOS9.0之后新增CASpringAnimation类它实现弹簧效果的动画 是CABaseAnimation的子类
 */
/** 直接用到的相关类
 CABaseAnimation
 CAKeyframeAnimation
 CATransition
 CAAnimationGroup
 CASpingAnimation
 */
/**
 CAMediaTiming(协议)----------------------->CAAnimation(遵守协议)
                                                 .
                                                 .
 CAAnimationGroup   CAPropertyAnimation   CATransition
                            .
                            .
         CABaseAniamtion       CAKeyframeAnimation
 
 */
#import "AnimationController.h"

@interface AnimationController ()
@property(nonatomic,strong)UIImageView * subView;
@end

@implementation AnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:0.98f green:0.97f blue:0.90f alpha:1.00f];
    UIImageView * subView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    subView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:subView];
    self.subView = subView;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self caTransition];

}

/**
 CATransaction 事务
 在CoreAnimation里存在CATranscation这样一个概念 它负责协调多个动画原子更新显示操作
 简单来说事务是CoreAniamtion里面的一个基本单元,动画的产生必然伴随着Layer的Aniamtion属性的变化 而Layer属性的变化必须属于某一个事务 因此CoreAnimation依赖事务
 事务的作用：保证一个或多个layer的一个或多个属性变化同时进行
 事务分为隐式和显式：
　　1.隐式：没有明显调用事务的方法，由系统自动生成事务。比如直接设置一个layer的position属性，则会在当前线程自动生成一个事务，并在下一个runLoop中自动commit事务。
　　2.显式：明显调用事务的方法（[CATransaction begin]和[CATransaction commit]）。

 */
- (void)caTransaction
{
    
}

/**
   CATransition转场动画,比UIView转场动画有更多的动画效果
 */
- (void)caTransition
{
    CATransition * transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    transition.duration = 0.5;
    self.subView.image = [UIImage imageNamed:@"10"];
    [self.subView.layer addAnimation:transition forKey:nil];
}
- (void)cakeyframeAnimation
{
    
    
    CAKeyframeAnimation * ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.duration = 3;
    ani.fillMode = kCAFillModeForwards;
    ani.removedOnCompletion = NO;
    ani.timingFunction = [CAMediaTimingFunction functionWithName:kCAFilterLinear];
    NSValue * value1 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    NSValue * value2 = [NSValue valueWithCGPoint:CGPointMake(250, 200)];
    NSValue * value3 = [NSValue valueWithCGPoint:CGPointMake(250, 300)];
    NSValue * value4 = [NSValue valueWithCGPoint:CGPointMake(150, 300)];
    NSValue * value5 = [NSValue valueWithCGPoint:CGPointMake(150, 200)];
    ani.values = @[value1,value2,value3,value4,value5];
    
    [self.subView.layer addAnimation:ani forKey:@"position"];
}
@end





























