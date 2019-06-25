//
//  NetworkAdditionalInfoService.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkLoadingServiceOutputProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkAdditionalInfoService : NSObject <NetworkLoadingServiceInputProtocol,NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, weak) id<NetworkLoadingServiceOutputProtocol> output;

-(void) flickrPhotoInfoWithUniqueId:(NSInteger) uniqueId;

@end

NS_ASSUME_NONNULL_END
