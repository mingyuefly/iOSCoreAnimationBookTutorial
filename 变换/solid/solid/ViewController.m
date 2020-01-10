//
//  ViewController.m
//  solid
//
//  Created by Gguomingyue on 2020/1/10.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"

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
}

-(void)createFaces
{
    NSMutableArray *array = [@[] mutableCopy];
    for (int i = 0; i < 6; i++) {
        UIView *faceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        faceView.backgroundColor = [UIColor whiteColor];
        faceView.tag = i;
        [array addObject:faceView];
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.text = [NSString stringWithFormat:@"%d", i + 1];
        numLabel.textAlignment = NSTextAlignmentCenter;
        numLabel.textColor = [UIColor redColor];
        numLabel.font = [UIFont systemFontOfSize:40];
        numLabel.frame = faceView.bounds;
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
