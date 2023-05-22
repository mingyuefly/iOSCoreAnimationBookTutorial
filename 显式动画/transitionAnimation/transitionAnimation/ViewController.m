//
//  ViewController.m
//  transitionAnimation
//
//  Created by Gguomingyue on 2020/1/20.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) NSArray<NSString *> *imageNames;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, copy) NSArray<UIImage *> *images;
@property (nonatomic, strong) UIButton *button3;
//@property (nonatomic, strong) UIImageView *imageView3;
@property (nonatomic, strong) UIView *imageView3;
@property (nonatomic, strong) CALayer *imageLayer3;
@property (nonatomic, strong) UIButton *button4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Transition";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.imageView];
    self.imageView.center = CGPointMake(self.view.bounds.size.width / 2, 100);
    [self.view addSubview:self.button];
    self.button.center = CGPointMake(self.view.bounds.size.width / 2, 200);
    [self.view addSubview:self.imageView2];
    self.imageView2.center = CGPointMake(self.view.bounds.size.width / 2, 330);
    [self.view addSubview:self.button2];
    self.button2.center = CGPointMake(self.view.bounds.size.width / 2, 400);
    [self.view addSubview:self.imageView3];
    self.imageView3.center = CGPointMake(self.view.bounds.size.width / 2, 530);
    [self.view addSubview:self.button3];
    self.button3.center = CGPointMake(self.view.bounds.size.width / 2, 600);
    [self.imageView3.layer addSublayer:self.imageLayer3];
    self.imageLayer3.contentsCenter = self.imageView3.bounds;
    [self.view addSubview:self.button4];
    self.button4.center = CGPointMake(self.view.bounds.size.width / 2, 640);
}

#pragma mark - actions
-(void)switchAction
{
    //    if (!self.imageView.animating) {
    //        [self.imageView startAnimating];
    //    } else {
    //        [self.imageView stopAnimating];
    //    }
    
    [UIView transitionWithView:self.imageView duration:1.0
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
        //cycle to next image
        UIImage *currentImage = self.imageView.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1) % [self.images count];
        self.imageView.image = self.images[index];
    } completion:NULL];
}

-(void)switchAction2
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    //    transition.type = kCATransitionPush;
    //    transition.type = kCATransitionMoveIn;
    //    transition.type = kCATransitionReveal;
    transition.duration = 2.0f;
    [self.imageView2.layer addAnimation:transition forKey:nil];
    UIImage *currentImage = self.imageView2.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView2.image = self.images[index];
}

-(void)switchAction3
{
    NSUInteger index = arc4random() % 4;
    self.imageLayer3.contents = (__bridge id _Nullable)(self.images[index].CGImage);// 有隐式动画效果
    self.imageView.image = self.images[index];
}

-(void)switchAction4
{
    //preserve the current view snapshot
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
    //insert snapshot view in front of this one
    UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    //update the view (we'll simply randomize the layer background color)
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    //perform animation (anything you like)
    [UIView animateWithDuration:1.0 animations:^{
        //scale, rotate and fade the view
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //remove the cover view now we're finished with it
        [coverView removeFromSuperview];
    }];
}

#pragma mark - property
-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _imageView.animationImages = self.images;
        _imageView.image = _imageView.animationImages[0];
        _imageView.animationDuration = 2.0f;
        _imageView.animationRepeatCount = 0;
    }
    return _imageView;
}

-(UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 200, 30);
        [_button setTitle:@"switchImage" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

-(NSArray<NSString *> *)imageNames
{
    return @[@"Image1", @"Image2", @"Image3", @"Image4"];
}

-(UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _imageView2.image = self.images[0];
    }
    return _imageView2;
}

-(UIButton *)button2
{
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button2.frame = CGRectMake(0, 0, 200, 30);
        [_button2 setTitle:@"switchImage2" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(switchAction2) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button2;
}

-(NSArray<UIImage *> *)images
{
    static NSArray *array;
    if (!array || array.count == 0) {
        array = ({
            NSMutableArray<UIImage *> *array = [@[] mutableCopy];
            [self.imageNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [array addObject:[UIImage imageNamed:obj]];
            }];
            array;
        });
    }
    return array;
}

//-(NSArray<UIImage *> *)images
//{
//    return ({
//        NSMutableArray<UIImage *> *array = [@[] mutableCopy];
//        [self.imageNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [array addObject:[UIImage imageNamed:obj]];
//        }];
//        array;
//    });
//}

-(UIButton *)button3
{
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button3.frame = CGRectMake(0, 0, 200, 30);
        [_button3 setTitle:@"switchImage3" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button3 addTarget:self action:@selector(switchAction3) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button3;
}

-(UIView *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _imageView3;
}

-(CALayer *)imageLayer3
{
    if (!_imageLayer3) {
        _imageLayer3 = [CALayer layer];
        _imageLayer3.frame = CGRectMake(0, 0, 100, 100);
        _imageLayer3.contents = (__bridge id _Nullable)(self.images[0].CGImage);
    }
    return _imageLayer3;
}

-(UIButton *)button4
{
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        _button4.frame = CGRectMake(0, 0, 200, 30);
        [_button4 setTitle:@"switchImage4" forState:UIControlStateNormal];
        [_button4 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_button4 addTarget:self action:@selector(switchAction4) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button4;
}

@end
