//
//  ViewController.m
//  keyframeTimingFunction
//
//  Created by Gguomingyue on 2020/1/22.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *ballView;
@property (nonatomic, strong) UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"keyframeTimingFunction";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    //add ball image view
    UIImage *ballImage = [UIImage imageNamed:@"ballImage"];
    self.ballView = [[UIImageView alloc] initWithImage:ballImage];
    self.ballView.frame = CGRectMake(0, 0, 25, 25);
    [self.containerView addSubview:self.ballView];
    //animate
    [self animate];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //replay animation on tap
    [self animate];
}

- (void)animate
{
    //reset ball to top of screen
    self.ballView.center = CGPointMake(150, 32);
    //create keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.duration = 1.0;
    animation.delegate = self;
    animation.values = @[
        [NSValue valueWithCGPoint:CGPointMake(150, 32)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
        [NSValue valueWithCGPoint:CGPointMake(150, 140)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
        [NSValue valueWithCGPoint:CGPointMake(150, 220)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)],
        [NSValue valueWithCGPoint:CGPointMake(150, 250)],
        [NSValue valueWithCGPoint:CGPointMake(150, 268)]
    ];
    
    animation.timingFunctions = @[
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut],
        [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
    ];
    
    animation.keyTimes = @[@0.0, @0.3, @0.5, @0.7, @0.8, @0.9, @0.95, @1.0];
    //apply animation
    self.ballView.layer.position = CGPointMake(150, 268);
    [self.ballView.layer addAnimation:animation forKey:nil];
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _containerView;
}


@end
