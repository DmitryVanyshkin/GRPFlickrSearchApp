//
//  ConvertNSDataToFullPhotoModel.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FullPhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConvertNSDataToFullPhotoModel : NSObject

-(FullPhotoModel*) convertToModelFromNSData : (NSData*) data;

@end

NS_ASSUME_NONNULL_END
