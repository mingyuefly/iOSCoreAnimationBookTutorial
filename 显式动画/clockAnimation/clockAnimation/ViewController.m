//
//  ViewController.m
//  clockAnimation
//
//  Created by Gguomingyue on 2020/1/20.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

@interface MyProxy : NSProxy

@property (nonatomic, weak) id target;

@end

@implementation MyProxy

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}

@end

@interface ViewController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *dialPlateImageView;
@property (nonatomic, strong) UIImageView *hourHandImageView;
@property (nonatomic, strong) UIImageView *minuteHandImageView;
@property (nonatomic, strong) UIImageView *secondHandImageView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) MyProxy *proxy;

@end

@implementation ViewController

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.proxy = [MyProxy alloc];
        self.proxy.target = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"scene";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    [self.view addSubview:self.dialPlateImageView];
    [self.view addSubview:self.hourHandImageView];
    [self.view addSubview:self.minuteHandImageView];
    [self.view addSubview:self.secondHandImageView];
    
    // 通过设置anchorPoint（锚点）取得偏移效果，将其设置于图层下方，图层会向上偏转，之后通过仿射变换旋转也以此点为锚点旋转
    self.hourHandImageView.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.minuteHandImageView.layer.anchorPoint = CGPointMake(0.5, 0.9);
    self.secondHandImageView.layer.anchorPoint = CGPointMake(0.5, 0.9);
    
    if (!self.timer || !self.timer.valid) {
        self.timer = [NSTimer timerWithTimeInterval:1 target:self.proxy selector:@selector(tickAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    [self.timer fire];
    [self tickAction];
}

#pragma mark - actions
-(void)tickAction
{
    //NSLog(@"tick");
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calender components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    self.hourHandImageView.transform = CGAffineTransformMakeRotation(hourAngle);
    self.minuteHandImageView.transform = CGAffineTransformMakeRotation(minuteAngle);
    self.secondHandImageView.transform = CGAffineTransformMakeRotation(secondAngle);
    
    [self updateHandsAnimated:YES];
}

- (void)updateHandsAnimated:(BOOL)animated
{
    //convert time to hours, minutes and seconds
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calender components:units fromDate:[NSDate date]];
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2.0;
    CGFloat minuteAngle = (components.minute / 60.0) * M_PI * 2.0;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2.0;
    //rotate hands
    [self setAngle:hourAngle forHand:self.hourHandImageView animated:animated];
    [self setAngle:minuteAngle forHand:self.minuteHandImageView animated:animated];
    [self setAngle:secondAngle forHand:self.secondHandImageView animated:animated];
}

- (void)setAngle:(CGFloat)angle forHand:(UIView *)handView animated:(BOOL)animated
{
    //generate transform
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated) {
        //create transform animation
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateHandsAnimated:NO];
        animation.keyPath = @"transform";
        animation.toValue = [NSValue valueWithCATransform3D:transform];
        animation.duration = 0.5;
        animation.delegate = self;
        [animation setValue:handView forKey:@"handView"];
        animation.fillMode = kCAFillModeForwards;
        [handView.layer addAnimation:animation forKey:nil];
    } else {
        //set transform directly
        handView.layer.transform = transform;
    }
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag
{
    //set final position for hand view
    UIView *handView = [anim valueForKey:@"handView"];
    handView.layer.transform = [anim.toValue CATransform3DValue];
}

#pragma mark - property
-(UIImageView *)dialPlateImageView
{
    if (!_dialPlateImageView) {
        _dialPlateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, 200, 200)];
        _dialPlateImageView.image = [UIImage imageNamed:@"dialPlateImage"];
    }
    return _dialPlateImageView;
}

-(UIImageView *)hourHandImageView
{
    if (!_hourHandImageView) {
        _hourHandImageView = [[UIImageView alloc] initWithFrame:CGRectMake(175, 100, 50, 100)];
        _hourHandImageView.image = [UIImage imageNamed:@"hourHandImage"];
    }
    return _hourHandImageView;
}

-(UIImageView *)minuteHandImageView
{
    if (!_minuteHandImageView) {
        _minuteHandImageView = [[UIImageView alloc] initWithFrame:CGRectMake(166, 65, 68, 171)];
        _minuteHandImageView.image = [UIImage imageNamed:@"minuteHandImage"];
    }
    return _minuteHandImageView;
}

-(UIImageView *)secondHandImageView
{
    if (!_secondHandImageView) {
        _secondHandImageView = [[UIImageView alloc] initWithFrame:CGRectMake(180, 37, 40, 226)];
        _secondHandImageView.image = [UIImage imageNamed:@"secondHandImage"];
    }
    return _secondHandImageView;
}

-(void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
