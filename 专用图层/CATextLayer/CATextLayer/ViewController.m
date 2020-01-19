//
//  ViewController.m
//  CATextLayer
//
//  Created by Gguomingyue on 2020/1/16.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CoreText.h>
#import "LayerLabel.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *labelView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:252/255.0f green:252/255.0f blue:252/255.0f alpha:1.0f];
    //self.view.backgroundColor = [UIColor grayColor];
    self.title = @"CATextLayer";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.edgesForExtendedLayout = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.view addSubview:self.labelView];
    self.labelView.center = CGPointMake(self.view.bounds.size.width / 2, 200);
    
    // 创建 CATextLayer
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.frame = self.labelView.frame;
    [self.labelView.layer addSublayer:textLayer];
    textLayer.foregroundColor = [UIColor blackColor].CGColor;
    textLayer.alignmentMode = kCAAlignmentJustified;
    //textLayer.alignmentMode = kCAAlignmentRight;
    textLayer.wrapped = YES;
    //textLayer.wrapped = NO;
    
    /*
     UIFont *font = [UIFont systemFontOfSize:15];
     CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
     CGFontRef fontRef = CGFontCreateWithFontName(fontName);
     textLayer.font = fontRef;
     textLayer.fontSize = font.pointSize;
     CGFontRelease(fontRef);
     NSString *text = @"Lorem ipsum dolor sitamet, consectetur adipiscing  elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel  fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet  lobortis";
     textLayer.string = text;
     
     // 解决像素化问题
     textLayer.contentsScale = [UIScreen mainScreen].scale;
     */
    
    UIFont *font = [UIFont systemFontOfSize:15];
    //NSString *text = @"Lorem ipsum dolor sitamet, consectetur adipiscing  elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel  fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet  lobortis";
    
    NSString *text = @"Lorem ipsum dolor sitamet, consectetur adipiscing  elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar  leo.";
    NSMutableAttributedString *string = nil;
    //create attributed string
    string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    CFStringRef fontName = (__bridge CFStringRef)(font.fontName);
    CGFloat fontSize = font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //set text attributes
    NSDictionary *attribs = @{
        (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor blackColor].CGColor,
        (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
    };
    [string setAttributes:attribs range:NSMakeRange(0, text.length)];
    attribs = @{
        (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
        (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
        (__bridge id)kCTFontAttributeName: (__bridge id)fontRef
    };
    [string setAttributes:attribs range:NSMakeRange(6, 5)];
    
    //release the CTFont we created earlier
    CFRelease(fontRef);
    //set layer text
    textLayer.string = string;
    
    LayerLabel *label = [[LayerLabel alloc] initWithFrame:CGRectMake(10, 400, 200, 200)];
    label.layer.backgroundColor = [UIColor redColor].CGColor;
    label.text = @"Lorem ipsum dolor sitamet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo.";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
}

-(UIView *)labelView
{
    if (!_labelView) {
        _labelView = [[UIView alloc] init];
        _labelView.frame = CGRectMake(0, 0, 300, 300);
        _labelView.backgroundColor = [UIColor lightGrayColor];
    }
    return _labelView;
}


@end
