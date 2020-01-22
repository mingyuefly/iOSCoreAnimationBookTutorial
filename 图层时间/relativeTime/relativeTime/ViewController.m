//
//  ViewController.m
//  relativeTime
//
//  Created by Gguomingyue on 2020/1/22.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIBezierPath *bezierPath;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) CALayer *shipLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"relativeTime";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.button];
    self.button.center = CGPointMake(self.view.bounds.size.width / 2, 450);
    //create a path
    self.bezierPath = [[UIBezierPath alloc] init];
    [self.bezierPath moveToPoint:CGPointMake(self.view.bounds.size.width / 2, 100)];
    [self.bezierPath addCurveToPoint:CGPointMake(self.view.bounds.size.width / 2, 400) controlPoint1:CGPointMake(50, 200) controlPoint2:CGPointMake(self.view.bounds.size.width - 50, 300)];
    //draw the path using a CAShapeLayer
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.path = self.bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    //add the ship
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 64, 64);
    self.shipLayer.position = CGPointMake(self.view.bounds.size.width / 2, 100);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed: @"shipImage.png"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
}

-(void)playAction
{
    //create the keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.timeOffset = 3;
    //animation.speed = 5;
    animation.duration = 10;
    animation.path = self.bezierPath.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = NO;
    animation.delegate = self;
    [self.shipLayer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.shipLayer.position = CGPointMake(self.view.bounds.size.width / 2, 400);
    [CATransaction commit];
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _containerView;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 100, 30);
        [_button addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
        [_button setTitle:@"play" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    return _button;
}

@end
