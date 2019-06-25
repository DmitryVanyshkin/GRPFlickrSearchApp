//
//  NetworkFlickrSearchingService.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkLoadingServiceOutputProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetworkFlickrSearchingService : NSObject <NetworkLoadingServiceInputProtocol,NSURLSessionDelegate, NSURLSessionTaskDelegate>

@property (nonatomic, weak) id<NetworkLoadingServiceOutputProtocol> output;

-(void) findFlickrPhotosWithSearchString:(NSString *)searchString;
-(void) findFlickrPhotosWithSearchString:(NSString *)searchString forPage:(NSInteger) page;
-(void) killCurrentTask;

@end

NS_ASSUME_NONNULL_END
