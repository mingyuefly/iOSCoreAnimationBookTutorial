//
//  ViewController.m
//  customerFunction
//
//  Created by Gguomingyue on 2020/1/22.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"customerTimingFunction";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.layerView];
    self.layerView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2 - 64);
    //create timing function
    //CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    //CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    //CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    //get control points
    CGPoint controlPoint1, controlPoint2;
    struct MY_CGPoint {
        float x;
        float y;
    };
    struct MY_CGPoint tempControlPoint1, tempControlPoint2;
    [function getControlPointAtIndex:1 values:(float *)&tempControlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&tempControlPoint2];
    controlPoint1.x = tempControlPoint1.x;
    controlPoint1.y = tempControlPoint1.y;
    controlPoint2.x = tempControlPoint2.x;
    controlPoint2.y = tempControlPoint2.y;
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(300, 300)];
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    //flip geometry so that 0,0 is in the bottom-left
    self.layerView.layer.geometryFlipped = YES;
}

-(UIView *)layerView
{
    if (!_layerView) {
        _layerView = [[UIView alloc] init];
        _layerView.frame = CGRectMake(0, 0, 300, 300);
        _layerView.backgroundColor = [UIColor blueColor];
    }
    return _layerView;
}

// 给时钟添加一个自定义时间线函数动效，懒得添加时钟相关代码了
- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView ￼animated:(BOOL)animated
{
    //generate transform
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"transform";
        animation.fromValue = [handView.layer.presentationLayer valueForKey:@"transform"];
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        //apply animation
        handView.layer.transform = transform;
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        //set transform directly
        handView.layer.transform = transform;
    }
}

@end
