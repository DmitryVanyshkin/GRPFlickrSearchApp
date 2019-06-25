//
//  ConvertNSDataToFullPhotoModel.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "ConvertNSDataToFullPhotoModel.h"

@implementation ConvertNSDataToFullPhotoModel

-(FullPhotoModel*) convertToModelFromNSData : (NSData*) data
{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSLog(@"%@", jsonObject);
    
    NSString* author = (NSString*)jsonObject[@"photo"][@"owner"][@"username"];
    NSString* title = (NSString*)jsonObject[@"photo"][@"title"][@"_content"];
    NSNumber *timeInterval = (NSNumber*)jsonObject[@"photo"][@"dates"][@"posted"];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: [timeInterval doubleValue]];
    
    NSString* description = (NSString*)jsonObject[@"photo"][@"description"][@"_content"];
    NSString* location = (NSString*)jsonObject[@"photo"][@"owner"][@"location"];
    
    
    FullPhotoModel *model = [[FullPhotoModel alloc]initWithAuthor:author title:title postDate:date description:description location:location];
    
    return model;
    
}

@end
