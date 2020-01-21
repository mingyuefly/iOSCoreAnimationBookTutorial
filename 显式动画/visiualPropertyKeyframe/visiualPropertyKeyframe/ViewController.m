//
//  ViewController.m
//  visiualPropertyKeyframe
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
    self.title = @"visualPropertyKeyframe";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    CALayer *shipLayer = [CALayer layer];
    shipLayer.frame = CGRectMake(0, 0, 128, 128);
    shipLayer.position = CGPointMake(150, 150);
    shipLayer.contents = (__bridge id)[UIImage imageNamed: @"spaceshipImage"].CGImage;
    [self.containerView.layer addSublayer:shipLayer];
    self.shipLayer = shipLayer;
    //animate the ship rotation
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation";
    animation.duration = 2.0;
    //animation.toValue = @(2 * M_PI);
    animation.toValue = @(M_PI);
    //animation.byValue = @(2 * M_PI);
    //animation.byValue = @(M_PI);
    animation.delegate = self;
    [shipLayer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CATransform3D transform = CATransform3DMakeRotation(((NSNumber *)anim.toValue).doubleValue, 0, 0, 1);
    self.shipLayer.transform = transform;
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
