//
//  ViewController.m
//  alpha
//
//  Created by Gguomingyue on 2020/1/8.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f blue:222/255.0f alpha:1.0f];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"alpha";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(200, 150);
    [self.view addSubview:button1];
    
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button2 = [[UIButton alloc] initWithFrame:frame];
    button2.backgroundColor = [UIColor whiteColor];
    button2.layer.cornerRadius = 10;
    button2.alpha = 0.5;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    label.alpha = 0.5;
    [button2 addSubview:label];
    button2.center = CGPointMake(200, 300);
    [self.view addSubview:button2];
    
    //create translucent button
//    UIButton *button2 = [self customButton];
//    button2.center = CGPointMake(200, 300);
//    button2.alpha = 0.5;
//    [self.view addSubview:button2];
    
    //enable rasterization for the translucent button
    // 最新的系统下运行这个区别不大，可能内部框架优化了
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

-(UIButton *)customButton
{
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    return button;
}


@end
