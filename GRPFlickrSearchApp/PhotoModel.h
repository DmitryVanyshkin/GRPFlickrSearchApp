//
//  PhotoModel.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoModel : NSObject

-(instancetype) initWithFarm:(NSInteger)farm uniqueId:(NSInteger)uniqueId isFamily:(BOOL)isFamily isFriend:(BOOL)isFriend isPublic:(BOOL)isPublic owner:(NSString*)owner secret:(NSString*)secret server:(NSString*) server title:(NSString*)title;

@property  (nonatomic, readonly) NSInteger farm;
@property  (nonatomic, readonly) NSInteger uniqueId;
@property  (nonatomic, readonly) BOOL isFamily;
@property  (nonatomic, readonly) BOOL isFriend;
@property  (nonatomic, readonly) BOOL isPublic;
@property  (nonatomic, readonly) NSString *owner;
@property  (nonatomic, readonly) NSString *secret;
@property  (nonatomic, readonly) NSString *server;
@property  (nonatomic, readonly) NSString *title;
@property  (nonatomic, readonly) UIImage *image;
@property  (nonatomic, readonly) double loadProgress;

-(void) setImage:(UIImage * _Nonnull)image;

@end

NS_ASSUME_NONNULL_END
