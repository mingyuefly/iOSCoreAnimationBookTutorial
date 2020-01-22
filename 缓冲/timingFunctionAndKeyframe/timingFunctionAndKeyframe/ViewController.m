//
//  ViewController.m
//  timingFunctionAndKeyframe
//
//  Created by Gguomingyue on 2020/1/22.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"timingFunctionAndKeyframe";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.layerView];
    [self.layerView addSubview:self.button];
    self.button.center = CGPointMake(self.view.bounds.size.width / 2, 300);
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
}

- (void)changeColor
{
    //create a keyframe animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.duration = 6.0;
    animation.values = @[
        (__bridge id)[UIColor blueColor].CGColor,
        (__bridge id)[UIColor redColor].CGColor,
        (__bridge id)[UIColor greenColor].CGColor,
        (__bridge id)[UIColor blueColor].CGColor ];
    //add timing function
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn];
    CAMediaTimingFunction *fn2 = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    CAMediaTimingFunction *fn3 = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionLinear];
    animation.timingFunctions = @[fn, fn2, fn3];
    //apply animation to layer
    [self.colorLayer addAnimation:animation forKey:nil];
}

-(UIView *)layerView
{
    if (!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _layerView;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 200, 30);
        [_button setTitle:@"changeColor" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


@end
