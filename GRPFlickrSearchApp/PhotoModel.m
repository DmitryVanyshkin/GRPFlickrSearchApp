//
//  PhotoModel.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "PhotoModel.h"


@interface PhotoModel()

@property  (nonatomic, assign) NSInteger farm;
@property  (nonatomic, assign) NSInteger uniqueId;
@property  (nonatomic, assign) BOOL isFamily;
@property  (nonatomic, assign) BOOL isFriend;
@property  (nonatomic, assign) BOOL isPublic;
@property  (nonatomic, strong) NSString *owner;
@property  (nonatomic, strong) NSString *secret;
@property  (nonatomic, assign) NSString *server;
@property  (nonatomic, strong) NSString *title;
@property  (nonatomic, strong) UIImage *image;
@property  (nonatomic, assign) double loadProgress;

@end

@implementation PhotoModel

-(instancetype) initWithFarm:(NSInteger)farm uniqueId:(NSInteger)uniqueId isFamily:(BOOL)isFamily isFriend:(BOOL)isFriend isPublic:(BOOL)isPublic owner:(NSString*)owner secret:(NSString*)secret server:(NSString*) server title:(NSString*)title
{
    self = [super init];
    
    if (self)
    {
        _farm = farm;
        _uniqueId = uniqueId;
        _isFamily = isFamily;
        _isFriend = isFriend;
        _isPublic = isPublic;
        _owner = owner;
        _secret = secret;
        _server = server;
        _title = title;
        _loadProgress = 0;
        
    }
    
    return self;
}

-(void) setImage:(UIImage*) image
{
    if (!_image)
    {
        _image = [UIImage new];
    }
    
    _image = image;
}

@end
