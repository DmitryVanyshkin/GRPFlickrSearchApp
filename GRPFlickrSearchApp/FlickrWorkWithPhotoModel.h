//
//  FlickrWorkWithPhotoModel.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlickrWorkWithPhotoModel : NSObject



-(instancetype) initWithTotal:(NSInteger) total pagesAmount:(NSInteger) pagesAmount pageNumber:(NSInteger) pageNumber perPage:(NSInteger) perPage photoModelArray: (NSArray*) photoModelArray;

@property (nonatomic, readonly) NSInteger total;
@property (nonatomic, readonly) NSInteger pagesAmount;
@property (nonatomic, readonly) NSInteger pageNumber;
@property (nonatomic, readonly) NSInteger perPage;
@property (nonatomic, readonly) NSMutableArray<PhotoModel*>* photoModelArray;

-(void) setImageForObjectAtIndex: (NSInteger) index image: (UIImage*) image;

@end

NS_ASSUME_NONNULL_END
