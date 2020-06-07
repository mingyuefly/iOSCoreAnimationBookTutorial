//
//  ViewController.m
//  CATranscation
//
//  Created by Gguomingyue on 2020/1/19.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"implicitCoreAnimation";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    self.containerView.center = CGPointMake(self.view.bounds.size.width / 2, 200);
    [self.containerView addSubview:self.button];
    self.button.center = CGPointMake(self.containerView.bounds.size.width / 2, self.containerView.bounds.size.height - 20);
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.containerView.bounds.size.width / 2, 100);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.containerView.layer addSublayer:self.colorLayer];
}

-(void)changeColorAction
{
    //begin a new transaction
    [CATransaction begin];
    //set the animation duration to 1 second
    [CATransaction setAnimationDuration:2.0];
    //add the spin animation on completion
    [CATransaction setCompletionBlock:^{
        [CATransaction begin];
        //set the animation duration to 1 second
        [CATransaction setAnimationDuration:2.0];
        //rotate the layer 90 degrees
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
        [CATransaction commit];
    }];
    //randomize the layer background color
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    //commit the transaction
    [CATransaction commit];
    self.view.layer;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _containerView.backgroundColor = [UIColor lightGrayColor];
    }
    return _containerView;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 200, 30);
        [_button setTitle:@"changeColor" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(changeColorAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end
