//
//  NetworkHelper.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 24/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "NetworkHelper.h"


@implementation NetworkHelper

+ (NSString *)URLForSearchString:(NSString *)searchString
{
    NSString *APIKey = @"8cd3a4189fbdb9db36c2638a50fc13db";
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1", APIKey, searchString];
}

+ (NSString *)URLForLoadingImagesWithUniqueId:(NSInteger) uniqueId farm:(NSInteger) farm server:(NSString*) server
secret: (NSString*) secret
{
//    NSString *APIKey = @"8cd3a4189fbdb9db36c2638a50fc13db";
    return [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", @(farm), server, @(uniqueId), secret];
}

+(NSString *)URLForLoadingInfoWithUniqueId:(NSInteger)uniqueId
{
    NSString *APIKey = @"8cd3a4189fbdb9db36c2638a50fc13db";
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=%@&photo_id=%@&format=json&nojsoncallback=1", APIKey, @(uniqueId)];
}

+ (NSString *)URLForSearchString:(NSString *)searchString pageNumber:(NSInteger)pageNumber
{
    NSString *APIKey = @"5553e0626e5d3a905df9a76df1383d98";
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&page=%@&format=json&nojsoncallback=1", APIKey, searchString, @(pageNumber)];
}


@end
