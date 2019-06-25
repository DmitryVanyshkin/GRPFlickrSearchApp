//
//  PhotoCollectionViewCell.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "PhotoCollectionViewCell.h"
#import "LoadingCircleView.h"

@interface PhotoCollectionViewCell()

@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) LoadingCircleView *loadingCircleView;


@end

@implementation PhotoCollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _photoImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _loadingCircleView = [[LoadingCircleView alloc]initWithFrame:CGRectZero];
        
        [self.contentView addSubview:_photoImageView];
        [self.contentView addSubview:_loadingCircleView];
        [self setConstraints];
        
    }
    
    return self;
    
}


-(void) setImageForImageView:(UIImage *)image
{
    self.photoImageView.image = image;
    [self.loadingCircleView setHidden:YES];
}

-(void) setStrokeEnd:(CGFloat)strokeEnd
{
    [self.loadingCircleView setStrokeEnd:strokeEnd];
}

-(void) setConstraints
{
    self.photoImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.loadingCircleView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.photoImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.photoImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.photoImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    [self.photoImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    
    [self.loadingCircleView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
    [self.loadingCircleView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = YES;
    [self.loadingCircleView.widthAnchor constraintEqualToConstant:20].active = YES;
    [self.loadingCircleView.heightAnchor constraintEqualToConstant:20].active = YES;
        
}

-(void)prepareForReuse
{
    self.photoImageView.image = nil;
    [self.loadingCircleView setHidden:NO];
    [self setStrokeEnd:0];
}

@end
