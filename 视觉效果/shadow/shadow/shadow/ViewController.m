//
//  ViewController.m
//  shadow
//
//  Created by Gguomingyue on 2020/1/7.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *redView1;
@property (nonatomic, strong) UIView *layerView1;
@property (nonatomic, strong) UIView *layerView2;

@property (nonatomic, strong) UIView *shadowPathView1;
@property (nonatomic, strong) UIView *shadowPathView2;
@property (nonatomic, strong) UIImage *image;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    self.title = @"shadow";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    self.layerView1.layer.cornerRadius = 20.0f;
    self.layerView1.layer.borderWidth = 5.0f;
    self.layerView1.layer.shadowOpacity = 0.9;
    self.layerView1.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.layerView1.layer.shadowRadius = 50.0f;
    //self.layerView1.clipsToBounds = YES;
    // 裁剪超出父视图范围之外部分的同时，会将阴影也一并裁剪，这也许并不是我们期望的
//    self.layerView1.layer.masksToBounds = YES;
//    [self.view addSubview:self.layerView1];
//    [self.layerView1 addSubview:self.redView1];
    
    // 解决方式是给self.layerView1添加一个同等大小和边框没有阴影效果的self.layerView2，将子视图self.redView1添加到self.layerView2上，对self.layerView2进行截取
    self.layerView2.layer.cornerRadius = 20.0f;
    self.layerView2.layer.borderWidth = 5.0f;
    [self.view addSubview:self.layerView1];
    [self.layerView1 addSubview:self.layerView2];
    [self.layerView2 addSubview:self.redView1];
    self.layerView2.layer.masksToBounds = YES;
    
    // shadowPath 如果寄宿图有透明通道，阴影会覆盖透明通道
    [self.view addSubview:self.shadowPathView1];
    [self.view addSubview:self.shadowPathView2];
    self.shadowPathView1.layer.shadowOpacity = 0.5;
    self.shadowPathView2.layer.shadowOpacity = 0.5;
    self.shadowPathView2.layer.shadowColor = [UIColor redColor].CGColor;
    
    CGMutablePathRef squarPath = CGPathCreateMutable();
    CGPathAddRect(squarPath, NULL, self.shadowPathView1.bounds);
    self.shadowPathView1.layer.shadowPath = squarPath;
    CGPathRelease(squarPath);
    
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddEllipseInRect(circlePath, NULL, self.shadowPathView2.bounds);
    self.shadowPathView2.layer.shadowPath = circlePath;
    CGPathRelease(circlePath);
}

#pragma mark - property
-(UIView *)redView1
{
    if (!_redView1) {
        _redView1 = [[UIView alloc] initWithFrame:CGRectMake(-50, -50, 100, 100)];
        _redView1.backgroundColor = [UIColor redColor];
    }
    return _redView1;
}

-(UIView *)layerView1
{
    if (!_layerView1) {
        _layerView1 = [[UIView alloc] initWithFrame:CGRectMake(80, 50, 150, 150)];
        _layerView1.backgroundColor = [UIColor whiteColor];
    }
    return _layerView1;
}

-(UIView *)layerView2
{
    if (!_layerView2) {
        _layerView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _layerView2.backgroundColor = [UIColor whiteColor];
    }
    return _layerView2;
}

-(UIView *)shadowPathView1
{
    if (!_shadowPathView1) {
        _shadowPathView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 320, 60, 60)];
        _shadowPathView1.layer.contents = (__bridge id _Nullable)(self.image.CGImage);
        //_shadowPathView1.backgroundColor = [UIColor redColor];
    }
    return _shadowPathView1;
}

-(UIView *)shadowPathView2
{
    if (!_shadowPathView2) {
        _shadowPathView2 = [[UIView alloc] initWithFrame:CGRectMake(200, 440, 60, 60)];
        _shadowPathView2.layer.contents = (__bridge id _Nullable)(self.image.CGImage);
        //_shadowPathView2.backgroundColor = [UIColor redColor];
    }
    return _shadowPathView2;
}

-(UIImage *)image
{
    if (!_image) {
        _image = [UIImage imageNamed:@"iconImage"];
    }
    return _image;
}

@end
