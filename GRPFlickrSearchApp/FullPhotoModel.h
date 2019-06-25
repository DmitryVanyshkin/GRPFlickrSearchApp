//
//  FullPhotoModel.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FullPhotoModel : NSObject

@property (nonatomic, readonly) NSString *author;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSDate *postDate;
@property (nonatomic, readonly) NSString *desrciption;
@property (nonatomic, readonly) NSString *location;

-(instancetype) initWithAuthor: (NSString*) author title:(NSString*)title postDate:(NSDate*) postDate description:(NSString*) description location:(NSString*)location;

@end

NS_ASSUME_NONNULL_END
