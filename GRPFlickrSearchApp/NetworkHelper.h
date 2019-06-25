//
//  NetworkHelper.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject

+ (NSString *)URLForSearchString:(NSString *)searchString;
+ (NSString *)URLForLoadingImagesWithUniqueId:(NSInteger) uniqueId farm:(NSInteger) farm server:(NSString*) server
secret: (NSString*) secret;
+(NSString *)URLForLoadingInfoWithUniqueId:(NSInteger)uniqueId;
+ (NSString *)URLForSearchString:(NSString *)searchString pageNumber:(NSInteger)pageNumber;

@end

NS_ASSUME_NONNULL_END
