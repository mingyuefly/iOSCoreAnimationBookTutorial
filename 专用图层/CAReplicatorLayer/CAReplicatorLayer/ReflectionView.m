//
//  ReflectionView.m
//  CAReplicatorLayer
//
//  Created by Gguomingyue on 2020/1/17.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ReflectionView.h"

@interface ReflectionView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ReflectionView

+ (Class)layerClass
{
    return [CAReplicatorLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    //this is called when view is created in code
    if ((self = [super initWithFrame:frame])) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    [self addSubview:self.imageView];
    //configure replicator
    CAReplicatorLayer *layer = (CAReplicatorLayer *)self.layer;
    layer.instanceCount = 2;
    
    //move reflection instance below original and flip vertically
    CATransform3D transform = CATransform3DIdentity;
    CGFloat verticalOffset = self.bounds.size.height + 2;
    transform = CATransform3DTranslate(transform, 0, verticalOffset, 0);
    transform = CATransform3DScale(transform, 1, -1, 0);
    layer.instanceTransform = transform;
    
    //reduce alpha of reflection layer
    layer.instanceAlphaOffset = -0.6;
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
