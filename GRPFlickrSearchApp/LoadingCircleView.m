//
//  LoadingCircleView.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "LoadingCircleView.h"

@interface LoadingCircleView()

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, assign) CGFloat circleRadius;
@property (nonatomic, assign) CGFloat strokeEnd;

@end


@implementation LoadingCircleView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _circleLayer = [[CAShapeLayer alloc]init];
        _circleRadius = 20;
        [self setupCircle];
    }
    
    return self;
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        _circleLayer = [[CAShapeLayer alloc] init];
        _circleRadius = 20;
        [self setupCircle];
    }
    
    return self;
}

-(void) setStrokeEnd:(CGFloat)strokeEnd
{
    if (strokeEnd > 1)
    {
        _strokeEnd = 1;
    }
    else if (strokeEnd < 0)
    {
        _strokeEnd = 0;
    }
    else
    {
        _strokeEnd = strokeEnd;
    }
    
    self.circleLayer.strokeEnd = _strokeEnd;
}

-(void) setupCircle
{
    self.circleLayer.frame = self.bounds;
    self.circleLayer.lineWidth = 2;
    self.circleLayer.fillColor = UIColor.clearColor.CGColor;
    self.circleLayer.strokeColor = UIColor.blueColor.CGColor;
    [self.layer addSublayer: self.circleLayer];
    self.backgroundColor = UIColor.whiteColor;
    
}

-(CGRect) circleFrame
{
    CGRect circleFrame = CGRectMake(0, 0, 2*self.circleRadius, 2*self.circleRadius);
    CGRect bounds = self.circleLayer.bounds;
    
    circleFrame.origin.x = CGRectGetMidX(bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(bounds) - CGRectGetMidY(circleFrame);
    
    return circleFrame;
}

-(UIBezierPath*) circlePath
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
    
    return path;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    self.circleLayer.frame = self.bounds;
    self.circleLayer.path = [self circlePath].CGPath;
}

@end
