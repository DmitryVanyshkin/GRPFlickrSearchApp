//
//  FullPhotoModel.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "FullPhotoModel.h"
@interface FullPhotoModel()

@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *postDate;
@property (nonatomic, strong) NSString *desrciption;
@property (nonatomic, strong) NSString *location;

@end

@implementation FullPhotoModel

-(instancetype) initWithAuthor: (NSString*) author title:(NSString*)title postDate:(NSDate*) postDate description:(NSString*) description location:(NSString*)location
{
    self = [super init];
    
    if (self)
    {
        _author = [NSString stringWithString:author];
        _title = [NSString stringWithString:title];
        _postDate = [NSDate new];
        _postDate = postDate;
        _desrciption = [NSString stringWithString:description];
        _location = [NSString stringWithString:location];
    }
    
    
    return self;
}

@end
