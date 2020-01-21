//
//  ViewController.m
//  keyframePathAnimation
//
//  Created by Gguomingyue on 2020/1/20.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CAKeyframePathAnimation";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(self.view.center.x, 100)];
    [bezierPath addCurveToPoint:CGPointMake(self.view.center.x, 400) controlPoint1:CGPointMake(50, 200) controlPoint2:CGPointMake(self.view.bounds.size.width - 50, 300)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 20, 20);
    shipLayer.position = CGPointMake(self.view.center.x, 100);
    shipLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"spaceshipImage"].CGImage);
    //shipLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.containerView.layer addSublayer:shipLayer];
    self.shipLayer = shipLayer;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 4.0f;
    animation.path = bezierPath.CGPath;
    // 确定飞船朝向和运动方向一致
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.delegate = self;
    [shipLayer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CAKeyframeAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.shipLayer.position = CGPointMake(self.view.center.x, 400);
    [CATransaction commit];
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _containerView;
}


@end
