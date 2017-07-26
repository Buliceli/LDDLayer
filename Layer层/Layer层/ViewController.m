//
//  ViewController.m
//  Layer层
//
//  Created by 李洞洞 on 24/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "UIView+LDDCicle.h"
#import "LDReplicatorAnimation.h"
@interface ViewController ()
@property(nonatomic,strong)CAGradientLayer * gradientLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layer13];
}

- (void)layer13 //复制层
{
    UIView *aniView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:aniView];
    [aniView.layer addSublayer: [LDReplicatorAnimation replicatorLayerWithType:LDReplicatorLayerGrid]];
    self.view.backgroundColor = [UIColor grayColor];
}
- (void)layer12 //利用mask属性切圆角
{
    UIImageView * imV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"10"]];
    [imV cicleMaskView:imV.center radius:imV.bounds.size.width*0.5];
    [self.view addSubview:imV];
    imV.center = self.view.center;
}
- (void)layer11 //有点反常识的遮罩 ->Layer的mask属性
{
    UIImageView * imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"10"]];
    imageV.frame = self.view.bounds;
    [self.view addSubview:imageV];
    
    //来个反向思维的遮罩 挡住的部分显示
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    CABasicAnimation * baseAnimation = [CABasicAnimation animation];
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:400 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    shapeLayer.path = path.CGPath;
   
    
    UIBezierPath * startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.view.center.x, self.view.center.y, 1, 1)];
   
    baseAnimation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    baseAnimation.toValue = (__bridge id _Nullable)(path.CGPath);
    baseAnimation.duration = 0.5;
    
    [shapeLayer addAnimation:baseAnimation forKey:@"path"];
    self.view.layer.mask = shapeLayer;
    
}
- (void)layer10 //小应用
{
    CGSize finalSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    CGFloat layerHeight = finalSize.height * 0.2;
    
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, finalSize.height - layerHeight)];
    [path addLineToPoint:CGPointMake(0, finalSize.height - 0)];
    [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height -0)];
    [path addLineToPoint:CGPointMake(finalSize.width, finalSize.height - layerHeight)];///<连接四个点>
#if 1
                               //曲线的终点 还是说起点 即终点
    [path addQuadCurveToPoint:CGPointMake(0, finalSize.height - layerHeight) controlPoint:CGPointMake(finalSize.width / 2, (finalSize.height - layerHeight) - 40)];
#endif
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
    
    UISwitch * sw = [[UISwitch alloc]initWithFrame:CGRectMake(64, 450, 50, 50)];
    
    
    [self.view.layer addSublayer:shapeLayer];
    [self.view addSubview:sw];
}
- (void)layer9
{
    CAShapeLayer * shapeLayer = [self layer6];
    CABasicAnimation * animation = [CABasicAnimation animation];
    animation.fromValue = @1;
    animation.toValue = @10;
    animation.duration = 2;
    [shapeLayer addAnimation:animation forKey:@"lineWidth"];
}
- (void)layer8
{
    CAShapeLayer * shapeLayer = [self layer6];
    shapeLayer.strokeStart = 0.5;
    shapeLayer.strokeEnd = 0.5;
    
    CABasicAnimation * baseAnimation = [CABasicAnimation animation];
    baseAnimation.fromValue = @0.5;
    baseAnimation.toValue = @0;
    baseAnimation.duration = 2;
    
    CABasicAnimation * baseAnimation1 = [CABasicAnimation animation];
    baseAnimation1.fromValue = @0.5;
    baseAnimation1.toValue = @1;
    baseAnimation1.duration = 2;
    
    [shapeLayer addAnimation:baseAnimation forKey:@"strokeStart"];
    [shapeLayer addAnimation:baseAnimation1 forKey:@"strokeEnd"];
}
- (void)layer7 //shapeLayer之动画
{
    //[self layer6];
    CABasicAnimation * baseAnimation = [CABasicAnimation animation];
    baseAnimation.fromValue = @0;
    baseAnimation.toValue = @1;
    baseAnimation.duration = 2;
    CAShapeLayer * layer = [self layer6];
    [layer addAnimation:baseAnimation forKey:@"strokeEnd"];
    
}
- (CAShapeLayer *)layer6 //画曲线 贝塞尔曲线的画法是由起点 终点 控制点 三个参数来画的
{
    CGPoint startPoint = CGPointMake(50, 300);
    CGPoint endPoint = CGPointMake(300, 300);
    CGPoint controlPoint = CGPointMake(170, 200);
    
    CALayer * layer1 = [CALayer layer];
    layer1.frame = CGRectMake(startPoint.x, startPoint.y, 5, 5);
    layer1.backgroundColor = [UIColor redColor].CGColor;
    
    
    CALayer * layer2 = [CALayer layer];
    layer2.frame = CGRectMake(endPoint.x, endPoint.y, 5, 5);
    layer2.backgroundColor = [UIColor redColor].CGColor;
    
    
    CALayer * layer3 = [CALayer layer];
    layer3.frame = CGRectMake(controlPoint.x, controlPoint.y, 5, 5);
    layer3.backgroundColor = [UIColor redColor].CGColor;
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    
    [path moveToPoint:startPoint];
    [path addQuadCurveToPoint:endPoint controlPoint:controlPoint];
    
    
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    
    [self.view.layer addSublayer:layer1];
    [self.view.layer addSublayer:layer2];
    [self.view.layer addSublayer:layer3];
    [self.view.layer addSublayer:shapeLayer];
    return shapeLayer;
}
- (void)layer5 //指定起始角 和 半径 画圆
{
    CGFloat radius = 60;
    CGFloat startAngle = 0;
    CGFloat endAngle = M_PI * 2;
    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor cyanColor].CGColor;
    
    [self.view.layer addSublayer:layer];
}
- (void)layer4
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(100, 100, 150, 100) cornerRadius:50];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
}
- (void)layer3
{
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:CGRectMake(100, 100, 100, 100)];
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充色
    shapeLayer.strokeColor = [UIColor cyanColor].CGColor;//边框色
    [self.view.layer addSublayer:shapeLayer];
}
- (void)layer2
{
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = CGRectMake(100, 100, 100, 100);
    shapeLayer.backgroundColor = [UIColor cyanColor].CGColor;
    [self.view.layer addSublayer:shapeLayer];
}
- (void)layer1
{
    CALayer * layer = [CALayer layer];
    //layer.frame = CGRectMake(0, 0, 150, 150);
    layer.position = CGPointMake(0, 0);
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    layer.bounds = CGRectMake(0, 0, 150, 150);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    
    [self.view.layer addSublayer:layer];
}
@end
