//
//  ScrollView.m
//  CAScrollLayer
//
//  Created by Gguomingyue on 2020/1/17.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ScrollView

+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    //enable clipping
    self.layer.masksToBounds = YES;
    [self addSubview:self.imageView];
    
    //attach pan gesture recognizer
    UIPanGestureRecognizer *recognizer = nil;
    recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:recognizer];
}

- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    //get the offset by subtracting the pan gesture
    //translation from the current bounds origin
    CGPoint offset = self.bounds.origin;
    offset.x -= [recognizer translationInView:self].x;
    offset.y -= [recognizer translationInView:self].y;
    NSLog(@"%@", [NSValue valueWithCGPoint:offset]);
    
    //scroll the layer
    [(CAScrollLayer *)self.layer scrollToPoint:offset];
    
    //reset the pan gesture translation
    [recognizer setTranslation:CGPointZero inView:self];
}

-(UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.image = [UIImage imageNamed:@"forestImage"];
    }
    return _imageView;
}

@end
