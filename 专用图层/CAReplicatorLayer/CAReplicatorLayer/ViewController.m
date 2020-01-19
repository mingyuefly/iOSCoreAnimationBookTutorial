//
//  ViewController.m
//  CAReplicatorLayer
//
//  Created by Gguomingyue on 2020/1/17.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "ReflectionView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ReflectionView *reflectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"CAReplicatorLayer";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //[self.view addSubview:self.containerView];
    self.containerView.center = CGPointMake(self.view.bounds.size.width / 2, 100);
    
    //create a replicator layer and add it to our view
    CAReplicatorLayer *replicator = [CAReplicatorLayer layer];
    replicator.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:replicator];
    
    //configure the replicator
    replicator.instanceCount = 10;
    
    //apply a transform for each instance
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0, 200, 0);
    transform = CATransform3DRotate(transform, M_PI / 5.0, 0, 0, 1);
    transform = CATransform3DTranslate(transform, 0, -200, 0);
    replicator.instanceTransform = transform;
    
    //apply a color shift for each instance
    replicator.instanceBlueOffset = -0.1;
    replicator.instanceGreenOffset = -0.1;
    
    //create a sublayer and place it inside the replicator
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(100.0f, 100.0f, 100.0f, 100.0f);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [replicator addSublayer:layer];
    
    [self.view addSubview:self.reflectionView];
    self.reflectionView.center = CGPointMake(self.view.bounds.size.width / 2, 300);
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _containerView;
}

-(ReflectionView *)reflectionView
{
    if (!_reflectionView) {
        _reflectionView = [[ReflectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _reflectionView;
}


@end
