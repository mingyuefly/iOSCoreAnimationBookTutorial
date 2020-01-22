//
//  ViewController.m
//  timingFunction
//
//  Created by Gguomingyue on 2020/1/22.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

/*
 @interface ViewController ()
 
 @property (nonatomic, strong) CALayer *colorLayer;
 
 @end
 
 @implementation ViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 self.view.backgroundColor = [UIColor whiteColor];
 self.title = @"timingFunction";
 self.edgesForExtendedLayout = UIRectEdgeNone;
 self.extendedLayoutIncludesOpaqueBars = NO;
 self.navigationController.navigationBar.translucent = NO;
 
 //create a red layer
 self.colorLayer = [CALayer layer];
 self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
 self.colorLayer.position = CGPointMake(self.view.bounds.size.width/2.0, self.view.bounds.size.height/2.0);
 self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
 [self.view.layer addSublayer:self.colorLayer];
 }
 
 - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
 {
 //configure the transaction
 [CATransaction begin];
 [CATransaction setAnimationDuration:1.0];
 [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
 //set the position
 self.colorLayer.position = [[touches anyObject] locationInView:self.view];
 //commit transaction
 [CATransaction commit];
 }
 
 @end
 */



@interface ViewController ()

@property (nonatomic, strong) UIView *colorView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"timingFunction";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //create a red layer
    self.colorView = [[UIView alloc] init];
    self.colorView.bounds = CGRectMake(0, 0, 100, 100);
    self.colorView.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    self.colorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.colorView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //perform the animation
    [UIView animateWithDuration:1.0 delay:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        //set the position
        self.colorView.center = [[touches anyObject] locationInView:self.view];
    }
                     completion:NULL];
    
}

@end
