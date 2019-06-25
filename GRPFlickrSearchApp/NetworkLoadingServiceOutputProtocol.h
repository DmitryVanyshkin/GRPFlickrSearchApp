//
//  NetworkLoadingServiceOutputProtocol.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#ifndef NetworkLoadingServiceOutputProtocol_h
#define NetworkLoadingServiceOutputProtocol_h

@protocol NetworkLoadingServiceOutputProtocol <NSObject>

@optional

-(void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved;
-(void)loadingIsDoneWithDataRecieved:(NSData *)dataRecieved at: (NSInteger) index;

-(void)loadingContinuesWithProgress:(double)progress at: (NSInteger) index;

@end

@protocol NetworkLoadingServiceInputProtocol <NSObject>

@optional

- (void)configureUrlSessionWithParams:(NSDictionary *)params;
- (void)startImageLoadingWithName : (NSString*) name;

// Next Step
- (BOOL)resumeNetworkLoadingWithName : (NSString*) name;
- (void)suspendNetworkLoadingWithName : (NSString*) name;

- (void)findFlickrPhotosWithSearchString:(NSString *)searchSrting;

@end


#endif /* NetworkLoadingServiceOutputProtocol_h */
