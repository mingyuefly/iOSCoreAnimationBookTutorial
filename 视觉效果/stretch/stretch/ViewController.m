//
//  ViewController.m
//  stretch
//
//  Created by Gguomingyue on 2020/1/8.
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

@interface ViewController ()

@property (nonatomic, copy) NSArray<UIView *> *viewArray;
@property (nonatomic, strong) UIView *digitView;
@property (nonatomic, strong) UIImage *digitsImage;
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
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    self.title = @"stretch";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.digitsImage = [UIImage imageNamed:@"digitsImage"];
    
    [self createViews];
    [self.view addSubview:self.digitView];
    
    if (!self.timer || !self.timer.valid) {
        self.timer = [NSTimer timerWithTimeInterval:1 target:self.proxy selector:@selector(tickAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    [self.timer fire];
    [self tickAction];
}

-(void)createViews
{
    NSMutableArray *array = [@[] mutableCopy];
    for (int i = 0; i < 6; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(20 + 44.2 * i, 40, 44.2, 64);
        view.layer.contents = (__bridge id _Nullable)(self.digitsImage.CGImage);
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
        [array addObject:view];
        [self.view addSubview:view];
    }
    self.viewArray = array;
}

#pragma mark - actions
-(void)tickAction
{
    //NSLog(@"tick");
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calender components:units fromDate:[NSDate date]];
    
    [self setDigit:components.hour/10 forView:self.viewArray[0]];
    [self setDigit:components.hour%10 forView:self.viewArray[1]];
    [self setDigit:components.minute/10 forView:self.viewArray[2]];
    [self setDigit:components.minute%10 forView:self.viewArray[3]];
    [self setDigit:components.second/10 forView:self.viewArray[4]];
    [self setDigit:components.second%10 forView:self.viewArray[5]];
}

-(void)setDigit:(NSInteger)digit forView:(UIView *)view
{
    view.layer.contentsRect = CGRectMake(digit * 0.1, 0, 0.1, 1.0);
}

-(UIView *)digitView
{
    if (!_digitView) {
        _digitView = [[UIView alloc] initWithFrame:CGRectMake(20, 120, 442, 640)];
        _digitView.layer.contents = (__bridge id _Nullable)(self.digitsImage.CGImage);
        _digitView.layer.contentsRect = CGRectMake(0.0001, 0.002, 0.0998, 0.996);
        _digitView.layer.contentsGravity = kCAGravityResizeAspect;
        // 使用最近过滤算法，使得图片太放大太多倍数时不模糊
        _digitView.layer.magnificationFilter = kCAFilterNearest;
    }
    return _digitView;
}

-(void)dealloc
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

@end
