//
//  ViewController.m
//  hitTest
//
//  Created by Gguomingyue on 2020/1/7.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *layerView;
@property (nonatomic, strong) CALayer *blueLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = @"hitTest";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.layerView];
    [self.layerView.layer addSublayer:self.blueLayer];
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    point = [self.layerView.layer convertPoint:point fromLayer:self.view.layer];
//    if ([self.layerView.layer containsPoint:point]) {
//        point = [self.blueLayer convertPoint:point fromLayer:self.layerView.layer];
//        if ([self.blueLayer containsPoint:point]) {
//            NSLog(@"Inside Blue Layer");
//        } else {
//            NSLog(@"Inside White Layer");
//        }
//    }
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    // 返回叶子节点图层，“当调用图层的-hitTest:方法时，测算的顺序严格依赖于图层树当中的图层顺序（和UIView处理事件类似）。之前提到的zPosition属性可以明显改变屏幕上图层的顺序，但不能改变事件传递的顺序。”
    CALayer *layer = [self.layerView.layer hitTest:point];
    if (layer == self.layerView.layer) {
        NSLog(@"Inside White Layer");
    } else if (layer == self.blueLayer) {
        NSLog(@"Inside Blue Layer");
    } else {
        //
    }
}

#pragma mark - property
-(UIView *)layerView
{
    if (!_layerView) {
        _layerView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _layerView.backgroundColor = [UIColor whiteColor];
    }
    return _layerView;
}

-(CALayer *)blueLayer
{
    if (!_blueLayer) {
        _blueLayer = [CALayer layer];
        _blueLayer.frame = CGRectMake(50, 50, 100, 100);
        _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    }
    return _blueLayer;
}

@end
