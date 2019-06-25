//
//  ConvertNSDataToPhotoModel.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlickrWorkWithPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConvertNSDataToPhotoModel : NSObject

-(FlickrWorkWithPhotoModel*) convertNSData : (NSData*) data;

@end

NS_ASSUME_NONNULL_END
