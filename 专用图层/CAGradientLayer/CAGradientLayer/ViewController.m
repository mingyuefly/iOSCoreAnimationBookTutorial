//
//  ViewController.m
//  CAGradientLayer
//
//  Created by Gguomingyue on 2020/1/17.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"CAGradientLayer";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.containerView];
    self.containerView.center = CGPointMake(self.view.bounds.size.width / 2, 200);
    
    //create gradient layer and add it to our container view
    /*
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
     */
    
    //create gradient layer and add it to our container view
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:gradientLayer];
    
    //set gradient colors
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id) [UIColor yellowColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
    
    //set locations
    gradientLayer.locations = @[@0.0, @0.25, @0.5];
    
    //set gradient start and end points
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _containerView;
}


@end
