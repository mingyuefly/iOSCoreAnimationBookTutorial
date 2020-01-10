//
//  ViewController.m
//  transform3D
//
//  Created by Gguomingyue on 2020/1/9.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *layerView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *layerView1;
@property (nonatomic, strong) UIImageView *layerView2;
@property (nonatomic, strong) UIView *containerView1;
@property (nonatomic, strong) UIImageView *layerView3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"alpha";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.layerView.center = CGPointMake(100, 100);
    [self.view addSubview:self.layerView];
    
    // 仅仅这样做达不到我们想要的效果，感觉只是在水平方向上一个压缩，原因是因为我们在用一个斜向视角来看，而不是透视
    //    CATransform3D transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    //    self.layerView.layer.transform = transform;
    
    // 通过设置CATransform3D的m34元素解决，投影变换
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0 / 500;
    transform = CATransform3DRotate(transform, M_PI_4, 0, 1, 0);
    self.layerView.layer.transform = transform;
    
    [self.view addSubview:self.containerView];
    self.layerView1.center = CGPointMake(80, 200);
    self.layerView2.center = CGPointMake(250, 200);
    [self.containerView addSubview:self.layerView1];
    [self.containerView addSubview:self.layerView2];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
    self.containerView.layer.sublayerTransform = perspective;
    
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView1.layer.transform = transform1;
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layerView2.layer.transform = transform2;
    
    [self.view addSubview:self.containerView1];
    [self.containerView1 addSubview:self.layerView3];
    self.layerView3.center = CGPointMake(self.containerView1.bounds.size.width / 2, self.containerView1.bounds.size.height / 2);
    
    /*
     // 达到预期效果
     CATransform3D outer = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
     self.containerView1.layer.transform = outer;
     CATransform3D inner = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
     self.layerView3.layer.transform = inner;
     */
    
    // 并未达到预期效果
    // 这是由于尽管Core Animation图层存在于3D空间之内，但它们并不都存在同一个3D空间。每个图层的3D场景其实是扁平化的，当你从正面观察一个图层，看到的实际上由子图层创建的想象出来的3D场景，但当你倾斜这个图层，你会发现实际上这个3D场景仅仅是被绘制在图层的表面。”
    CATransform3D outer = CATransform3DIdentity;
    outer = CATransform3DRotate(outer, M_PI_4, 0, 1, 0);
    self.containerView1.layer.transform = outer;
    CATransform3D inner = CATransform3DIdentity;
    inner = CATransform3DRotate(inner, -M_PI_4, 0, 1, 0);
    self.layerView3.layer.transform = inner;
}

#pragma mark - property
-(UIImageView *)layerView
{
    if (!_layerView) {
        _layerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconImage"]];
        _layerView.frame = CGRectMake(0, 0, 100, 100);
        //_layerView.contentMode = UIViewContentModeScaleAspectFill;
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    return _layerView;
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 350, 400)];
        _containerView.backgroundColor = [UIColor clearColor];
    }
    return _containerView;
}

-(UIImageView *)layerView1
{
    if (!_layerView1) {
        _layerView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconImage"]];
        _layerView1.frame = CGRectMake(0, 0, 100, 100);
        //_layerView1.contentMode = UIViewContentModeScaleAspectFill;
        _layerView1.backgroundColor = [UIColor whiteColor];
    }
    return _layerView1;
}

-(UIImageView *)layerView2
{
    if (!_layerView2) {
        _layerView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconImage"]];
        _layerView2.frame = CGRectMake(0, 0, 100, 100);
        //_layerView2.contentMode = UIViewContentModeScaleAspectFill;
        _layerView2.backgroundColor = [UIColor whiteColor];
    }
    return _layerView2;
}

-(UIView *)containerView1
{
    if (!_containerView1) {
        _containerView1 = [[UIView alloc] initWithFrame:CGRectMake(150, 400, 150, 150)];
        _containerView1.backgroundColor = [UIColor whiteColor];
    }
    return _containerView1;
}

-(UIImageView *)layerView3
{
    if (!_layerView3) {
        _layerView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"iconImage"]];
        _layerView3.frame = CGRectMake(0, 0, 100, 100);
        //_layerView2.contentMode = UIViewContentModeScaleAspectFill;
        _layerView3.backgroundColor = [UIColor clearColor];
    }
    return _layerView3;
}

@end
