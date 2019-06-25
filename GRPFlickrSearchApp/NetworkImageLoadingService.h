//
//  NetworkImageLoadingService.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkLoadingServiceOutputProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkImageLoadingService : NSObject <NetworkLoadingServiceInputProtocol, NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, weak) id<NetworkLoadingServiceOutputProtocol> output;

-(void)startLoadingImageForId: (NSInteger)uniqueId farm:(NSInteger) farm server:(NSString*) server
secret: (NSString*) secret at: (NSInteger) index;
-(void) killCurentTask;

@end

NS_ASSUME_NONNULL_END
