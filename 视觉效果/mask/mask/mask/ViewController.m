//
//  ViewController.m
//  mask
//
//  Created by Gguomingyue on 2020/1/8.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *maskImageView;//原图使用mask后的效果
@property (nonatomic, strong) UIImageView *imageView;//原图
@property (nonatomic, strong) UIImageView *maskView;//mask图

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    self.title = @"mask";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.maskView];
    
    // mask定义了要显示的轮廓，轮廓里显示父图层的color
    [self.view addSubview:self.maskImageView];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(8.5, 36.5, 100, 100);
    UIImage *maskImage = [UIImage imageNamed:@"maskImage"];
    maskLayer.contents = (__bridge id _Nullable)(maskImage.CGImage);
    self.maskImageView.layer.mask = maskLayer;
}

#pragma mark - property
-(UIImageView *)maskImageView
{
    if (!_maskImageView) {
        _maskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 117, 173)];
        _maskImageView.image = [UIImage imageNamed:@"imageImage"];
    }
    return _maskImageView;
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300, 117, 173)];
        _imageView.image = [UIImage imageNamed:@"imageImage"];
    }
    return _imageView;
}

-(UIImageView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 300, 100, 100)];
        _maskView.image = [UIImage imageNamed:@"maskImage"];
    }
    return _maskView;
}

@end
