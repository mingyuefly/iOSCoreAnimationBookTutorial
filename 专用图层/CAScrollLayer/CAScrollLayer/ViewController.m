//
//  ViewController.m
//  CAScrollLayer
//
//  Created by Gguomingyue on 2020/1/17.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import "ScrollView.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"CAScrollLayer";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.containerView];
    self.containerView.center = CGPointMake(self.view.bounds.size.width / 2, 300);
    [self.containerView addSubview:self.scrollView];
}

-(UIView *)containerView
{
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _containerView.backgroundColor = [UIColor redColor];
    }
    return _containerView;
}

-(ScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[ScrollView alloc] initWithFrame:self.containerView.bounds];
        _scrollView.backgroundColor = [UIColor blueColor];
    }
    return _scrollView;
}


@end
