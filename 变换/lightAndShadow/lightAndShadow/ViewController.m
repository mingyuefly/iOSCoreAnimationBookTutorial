//
//  ViewController.m
//  lightAndShadow
//
//  Created by Gguomingyue on 2020/1/10.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface ViewController ()

@property (nonatomic, copy) NSArray<UIView *> *faceArray;
@property (nonatomic, strong) UIView *cubeContainerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"solid";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    //
    self.cubeContainerView.center = CGPointMake(self.view.center.x, 300);
    [self.view addSubview:self.cubeContainerView];
    [self createFaces];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500;
    self.cubeContainerView.layer.sublayerTransform = perspective;
    
    // add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 50);
    [self addFace:0 withTransform:transform];
    // add cube face 2
    transform = CATransform3DMakeTranslation(50, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFace:1 withTransform:transform];
    // add cube face 3
    transform = CATransform3DMakeTranslation(0, -50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    // add cube face 4
    transform = CATransform3DMakeTranslation(0, 50, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFace:3 withTransform:transform];
    // add cube face 5
    transform = CATransform3DMakeTranslation(-50, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFace:4 withTransform:transform];
    // add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -50);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFace:5 withTransform:transform];
    
    // 旋转cube
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.cubeContainerView.layer.sublayerTransform = perspective;
}

-(void)addFace:(NSInteger)index withTransform:(CATransform3D)transform
{
    UIView *face = [self.faceArray objectAtIndex:index];
    [self.cubeContainerView addSubview:face];
    face.center = CGPointMake(self.cubeContainerView.bounds.size.width / 2, self.cubeContainerView.bounds.size.height / 2);
    face.layer.transform = transform;
    [self applyLightingToFace:face];
}

-(void)applyLightingToFace:(UIView *)face
{
    CALayer *layer = [CALayer layer];
    layer.frame = face.layer.bounds;
    [face.layer addSublayer:layer];
    
    CATransform3D transform = face.layer.transform;
    // 32位机器可以直接这样做
    //GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    // 64位机器需要一个将CGFloat转为float的过程
    struct CATransform3DByMe
    {
      float m11, m12, m13, m14;
      float m21, m22, m23, m24;
      float m31, m32, m33, m34;
      float m41, m42, m43, m44;
    };
    struct CATransform3DByMe tempTransform;
    for (int i = 0; i < 16; i++) {
        tempTransform.m11 = transform.m11;
        tempTransform.m12 = transform.m12;
        tempTransform.m13 = transform.m13;
        tempTransform.m14 = transform.m14;
        
        tempTransform.m21 = transform.m21;
        tempTransform.m22 = transform.m22;
        tempTransform.m23 = transform.m23;
        tempTransform.m24 = transform.m24;
        
        tempTransform.m31 = transform.m31;
        tempTransform.m32 = transform.m32;
        tempTransform.m33 = transform.m33;
        tempTransform.m34 = transform.m34;
        
        tempTransform.m41 = transform.m41;
        tempTransform.m42 = transform.m42;
        tempTransform.m43 = transform.m43;
        tempTransform.m44 = transform.m44;
    }
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&tempTransform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
    
//    UIColor *color = [UIColor greenColor];
//    UIColor *customColor = [color colorWithAlphaComponent:shadow];
//    layer.backgroundColor = customColor.CGColor;
    
    UILabel *label = (UILabel *)[face viewWithTag:1000];
    [face.layer insertSublayer:label.layer above:layer];
}

-(void)createFaces
{
    NSMutableArray *array = [@[] mutableCopy];
    for (int i = 0; i < 6; i++) {
        UIView *faceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        faceView.backgroundColor = [UIColor whiteColor];
        faceView.tag = i;
        //faceView.layer.borderWidth = 1.0f;
        [array addObject:faceView];
        UILabel *numLabel = [[UILabel alloc] init];
        //numLabel.backgroundColor = [UIColor whiteColor];
        numLabel.text = [NSString stringWithFormat:@"%d", i + 1];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = [UIColor redColor];
        numLabel.font = [UIFont systemFontOfSize:40];
        numLabel.frame = CGRectMake(0, 0, 40, 40);
        numLabel.center = faceView.center;
        numLabel.tag = 1000;
        [faceView addSubview:numLabel];
    }
    self.faceArray = array;
}

#pragma mark - property
-(UIView *)cubeContainerView
{
    if (!_cubeContainerView) {
        _cubeContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
        _cubeContainerView.backgroundColor = [UIColor colorWithRed:222/255.0f green:222/255.0f blue:222/255.0f alpha:1.0f];
    }
    return _cubeContainerView;
}


@end
