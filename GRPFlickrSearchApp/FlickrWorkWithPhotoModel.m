//
//  FlickrWorkWithPhotoModel.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "FlickrWorkWithPhotoModel.h"


@interface FlickrWorkWithPhotoModel()

@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger pagesAmount;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, strong) NSMutableArray<PhotoModel*>* photoModelArray;

@end

@implementation FlickrWorkWithPhotoModel

-(instancetype) initWithTotal:(NSInteger) total pagesAmount:(NSInteger) pagesAmount pageNumber:(NSInteger) pageNumber perPage:(NSInteger) perPage photoModelArray: (NSArray*) photoModelArray
{
    self = [super init];
    
    if (self)
    {
        _total = total;
        _pagesAmount = pagesAmount;
        _pageNumber = pageNumber;
        _perPage = perPage;
        _photoModelArray = [photoModelArray mutableCopy];
    }
    
    return self;
}

-(void) appendArrayWithArray:(NSArray*)array
{
    [self.photoModelArray addObjectsFromArray:array];
}

-(void) setImageForObjectAtIndex: (NSInteger) index image: (UIImage*) image
{
    [self.photoModelArray[index] setImage:image];
}

@end
