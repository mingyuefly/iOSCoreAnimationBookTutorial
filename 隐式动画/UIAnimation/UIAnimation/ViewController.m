//
//  ViewController.m
//  UIAnimation
//
//  Created by Gguomingyue on 2020/1/19.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *colorLayerView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"Animation";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    self.containerView.center = CGPointMake(self.view.bounds.size.width / 2, 200);
    [self.containerView addSubview:self.button];
    self.button.center = CGPointMake(self.containerView.bounds.size.width / 2, self.containerView.bounds.size.height - 20);
    self.colorLayerView = [[UIView alloc] init];
    self.colorLayerView.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayerView.center = CGPointMake(self.containerView.bounds.size.width / 2, 100);
    self.colorLayerView.backgroundColor = [UIColor redColor];
    [self.containerView addSubview:self.colorLayerView];
}

-(void)changeColorAction
{
    [UIView animateWithDuration:2 animations:^{
        //randomize the layer background color
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.colorLayerView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    }];
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
