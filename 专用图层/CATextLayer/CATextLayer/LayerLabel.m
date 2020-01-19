//
//  LayerLabel.m
//  CATextLayer
//
//  Created by Gguomingyue on 2020/1/16.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "LayerLabel.h"

@interface LayerLabel ()

@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation LayerLabel

+(Class)layerClass
{
    return [CATextLayer class];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    self.textLayer = (CATextLayer *)self.layer;
//    self.text = self.text;
//    self.textColor = self.textColor;
//    self.font = self.font;
    
    [self textLayer].alignmentMode = kCAAlignmentJustified;
    [self textLayer].wrapped = YES;
    [self.layer display];
}

- (void)setText:(NSString *)text
{
    super.text = text;
    //set layer text
    [self textLayer].string = text;
}

- (void)setTextColor:(UIColor *)textColor
{
    super.textColor = textColor;
    //set layer text color
    [self textLayer].foregroundColor = textColor.CGColor;
}

- (void)setFont:(UIFont *)font
{
    super.font = font;
    //set layer font
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    [self textLayer].font = fontRef;
    [self textLayer].fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

@end
