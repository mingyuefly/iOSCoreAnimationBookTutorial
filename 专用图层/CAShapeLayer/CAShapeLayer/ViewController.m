//
//  ViewController.m
//  CAShapeLayer
//
//  Created by Gguomingyue on 2020/1/15.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation ViewController

-(instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"CAShapeLayer";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
//    if([[UIDevice currentDevice]respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationLandscapeRight;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.view addSubview:self.containerView];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(175, 100)];
    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2 * M_PI clockwise:YES];
    [path moveToPoint:CGPointMake(150, 125)];
    
    [path addLineToPoint:CGPointMake(150, 175)];
    // 如果有连续addLineToPoint就会围成一个区间，无论是否闭合
    //[path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(125, 225)];
    [path moveToPoint:CGPointMake(150, 175)];
    [path addLineToPoint:CGPointMake(175, 225)];
    [path moveToPoint:CGPointMake(100, 150)];
    [path addLineToPoint:CGPointMake(200, 150)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    //shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor greenColor].CGColor;
    shapeLayer.lineWidth = 5.0f;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineJoinRound;
    shapeLayer.path = path.CGPath;
    [self.containerView.layer addSublayer:shapeLayer];
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:self.view.bounds];
        _containerView.backgroundColor = [UIColor grayColor];
    }
    return _containerView;
}

@end
