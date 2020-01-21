//
//  ViewController.m
//  customerTransition
//
//  Created by Gguomingyue on 2020/1/21.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy) NSArray<UIImage *> *images;
@property (nonatomic, copy) NSArray<NSString *> *imageNames;
@property (nonatomic, strong) UIImageView *imageView2;
@property (nonatomic, strong) UIButton *button2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"customerTransition";
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
}

-(void)switchAction
{
    [UIView transitionWithView:self.imageView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        //cycle to next image
        UIImage *currentImage = self.imageView.image;
        NSUInteger index = [self.images indexOfObject:currentImage];
        index = (index + 1) % [self.images count];
        self.imageView.image = self.images[index];
    } completion:NULL];
}

-(void)switchAction2
{
    static BOOL mainScreen;
    if (mainScreen) {
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
        mainScreen = NO;
    } else {
        //preserve the current view snapshot
        UIGraphicsBeginImageContextWithOptions(self.imageView2.bounds.size, YES, 0.0);
        [self.imageView2.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *coverImage = UIGraphicsGetImageFromCurrentImageContext();
        //insert snapshot view in front of this one
        UIView *coverView = [[UIImageView alloc] initWithImage:coverImage];
        coverView.frame = self.imageView2.bounds;
        [self.imageView2 addSubview:coverView];
        //update the view (we'll simply randomize the layer background color)
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.imageView2.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
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
        mainScreen = YES;
    }
}

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


@end
