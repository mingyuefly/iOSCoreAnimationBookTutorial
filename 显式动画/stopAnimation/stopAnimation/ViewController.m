//
//  ViewController.m
//  stopAnimation
//
//  Created by Gguomingyue on 2020/1/21.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) CALayer *shipLayer;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL finished;//是否在做动画

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"stopAnimation";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.finished = YES;
    
    [self.view addSubview:self.containerView];
    [self.containerView.layer addSublayer:self.shipLayer];
    [self.containerView addSubview:self.button];
    self.button.center = CGPointMake(self.view.bounds.size.width / 2, 300);
    self.shipLayer = [CALayer layer];
    self.shipLayer.frame = CGRectMake(0, 0, 128, 128);
    self.shipLayer.position = CGPointMake(150, 150);
    self.shipLayer.contents = (__bridge id)[UIImage imageNamed:@"shipImage"].CGImage;
    [self.containerView.layer addSublayer:self.shipLayer];
}

-(void)buttonAction
{
    if (self.finished) {
        [self.button setTitle:@"stop" forState:UIControlStateNormal];
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform.rotation";
        animation.duration = 2.0;
        animation.byValue = @(M_PI * 2);
        animation.delegate = self;
        [self.shipLayer addAnimation:animation forKey:@"rotateAnimation"];
    } else {
        [self.button setTitle:@"start" forState:UIControlStateNormal];
        [self.shipLayer removeAnimationForKey:@"rotateAnimation"];
    }
}

-(void)animationDidStart:(CAAnimation *)anim
{
    self.finished = NO;
    [self.button setTitle:@"stop" forState:UIControlStateNormal];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.finished = YES;
    [self.button setTitle:@"start" forState:UIControlStateNormal];
    NSLog(@"The animation stopped (finished: %@)", flag? @"YES": @"NO");
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _containerView;
}

-(CALayer *)shipLayer
{
    if (!_shipLayer) {
        _shipLayer = [CALayer layer];
    }
    return _shipLayer;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 200, 30);
        [_button setTitle:@"start" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


@end
