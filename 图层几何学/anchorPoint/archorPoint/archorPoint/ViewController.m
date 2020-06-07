//
//  ViewController.m
//  archorPoint
//
//  Created by mingyue on 2020/6/7.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *archorView;
@property (nonatomic, assign) BOOL isRotate;
@property (nonatomic, assign) BOOL archorPointChange;
@property (nonatomic, assign) BOOL isTranslation;
@property (nonatomic, assign) BOOL isAnimationRotate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"archorPoint";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 30, 200)];
    backView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:backView];
    
    self.archorView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 30, 200)];
    self.archorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.archorView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 350, 100, 30);
    [button setTitle:@"rotate" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(50, 400, 100, 30);
    [button1 setTitle:@"archorPointChange" forState:UIControlStateNormal];
    button1.backgroundColor = [UIColor redColor];
    [button1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(50, 450, 100, 30);
    [button2 setTitle:@"translation" forState:UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(50, 500, 100, 30);
    [button3 setTitle:@"rotate" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor redColor];
    [button3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
}

-(void)buttonAction
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (self.isRotate) {
        [UIView animateWithDuration:0.5 animations:^{
            self.archorView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.isRotate = NO;
            NSLog(@"frame = %@", @(self.archorView.frame));
            NSLog(@"bounds = %@", @(self.archorView.bounds));
            NSLog(@"center = %@", @(self.archorView.center));
            NSLog(@"layer.frame = %@", @(self.archorView.layer.frame));
            NSLog(@"layer.bounds = %@", @(self.archorView.layer.bounds));
            NSLog(@"layer.position = %@", @(self.archorView.layer.position));
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.archorView.transform = CGAffineTransformMakeRotation(M_PI/6);
        } completion:^(BOOL finished) {
            self.isRotate = YES;
            NSLog(@"frame = %@", @(self.archorView.frame));
            NSLog(@"bounds = %@", @(self.archorView.bounds));
            NSLog(@"center = %@", @(self.archorView.center));
            NSLog(@"layer.frame = %@", @(self.archorView.layer.frame));
            NSLog(@"layer.bounds = %@", @(self.archorView.layer.bounds));
            NSLog(@"layer.position = %@", @(self.archorView.layer.position));
        }];
    }
}

-(void)button1Action
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (!self.archorPointChange) {
        self.archorView.layer.anchorPoint = CGPointMake(0.5, 0.9);
        self.archorPointChange = YES;
    } else {
        self.archorView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.archorPointChange = NO;
    }
}

-(void)button2Action
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (!self.isTranslation) {
        [UIView animateWithDuration:0.5 animations:^{
            self.archorView.transform = CGAffineTransformMakeTranslation(100, 0);
        } completion:^(BOOL finished) {
            self.isTranslation = YES;
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.archorView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.isTranslation = NO;
        }];
    }
}

-(void)button3Action
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    if (![self.archorView.layer animationForKey:@"rotate"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
        animation.duration = 1.0f;
        animation.repeatCount = MAXFLOAT;
        animation.cumulative = YES;
        [self.archorView.layer addAnimation:animation forKey:@"rotate"];
        CFTimeInterval pausedTime = [self.archorView.layer convertTime:CACurrentMediaTime() toLayer:nil];
        self.archorView.layer.speed = 0;
        self.archorView.layer.timeOffset = pausedTime;
    }
    if (!self.isAnimationRotate) {
        CFTimeInterval pausedTime = [self.archorView.layer timeOffset];
        self.archorView.layer.speed = 1.0f;
        self.archorView.layer.timeOffset = 0.0f;
        self.archorView.layer.beginTime = 0.0f;
        CFTimeInterval timeSincePause = [self.archorView.layer convertTime:CACurrentMediaTime() toLayer:nil] - pausedTime;
        self.archorView.layer.beginTime = timeSincePause;
        self.isAnimationRotate = YES;
    } else {
        CFTimeInterval pausedTime = [self.archorView.layer convertTime:CACurrentMediaTime() toLayer:nil];
        self.archorView.layer.speed = 0;
        self.archorView.layer.timeOffset = pausedTime;
        self.isAnimationRotate = NO;
    }
}


@end
