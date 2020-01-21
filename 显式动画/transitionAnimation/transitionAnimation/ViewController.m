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
}

-(void)switchAction
{
    if (!self.imageView.animating) {
        [self.imageView startAnimating];
    } else {
        [self.imageView stopAnimating];
    }
}

-(void)switchAction2
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    //transition.type = kCATransitionPush;
    transition.duration = 2.0f;
    [self.imageView2.layer addAnimation:transition forKey:nil];
    UIImage *currentImage = self.imageView2.image;
    NSUInteger index = [self.images indexOfObject:currentImage];
    index = (index + 1) % [self.images count];
    self.imageView2.image = self.images[index];
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

@end
