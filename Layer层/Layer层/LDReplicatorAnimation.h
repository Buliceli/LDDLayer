//
//  LDReplicatorAnimation.h
//  Layer层
//
//  Created by 李洞洞 on 26/7/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ReplicatorLayerType) {
    LDReplicatorLayerCircle,
    LDReplicatorLayerWave,   //波浪
    LDReplicatorLayerTriangle, //三角形
    LDReplicatorLayerGrid,  //网格
    LDReplicatorLayerShake,  //振动
    LDReplicatorLayerRound,
    LDReplicatorLayerHeart,
    LDReplicatorLayerTurn, //旋转
};
@interface LDReplicatorAnimation : NSObject
+ (CALayer *)replicatorLayerWithType:(ReplicatorLayerType)type;

// 波纹
+ (CALayer *)replicatorLayer_Circle;

// 波浪
+ (CALayer *)replicatorLayer_Wave;

// 三角形
+ (CALayer *)replicatorLayer_Triangle;

// 网格
+ (CALayer *)replicatorLayer_Grid;

// 振动条
+ (CALayer *)replicatorLayer_Shake;

// 转圈动画
+ (CALayer *)replicatorLayer_Round;

// 心动画
+ (CALayer *)replicatorLayer_Heart;
//旋转
+ (CALayer *)replicatorLayer_Turn;
@end
