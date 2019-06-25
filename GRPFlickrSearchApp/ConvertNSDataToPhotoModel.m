//
//  ConvertNSDataToPhotoModel.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "ConvertNSDataToPhotoModel.h"


@implementation ConvertNSDataToPhotoModel

-(FlickrWorkWithPhotoModel*) convertNSData : (NSData*) data
{
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

    NSInteger page =  [(NSNumber*)jsonObject[@"photos"][@"page"] integerValue];
    NSInteger pages = [(NSNumber*)jsonObject[@"photos"][@"pages"] integerValue];
    NSInteger perPage = [(NSNumber*)jsonObject[@"photos"][@"perpage"] integerValue];
    NSInteger total = [(NSNumber*)jsonObject[@"photos"][@"total"] integerValue];
    
    NSArray *photoesDataArray = (NSArray*)jsonObject[@"photos"][@"photo"];
    NSMutableArray<PhotoModel*> *photosArray = [NSMutableArray new];

    for (id model in photoesDataArray)
    {
        NSInteger farm =  [(NSNumber*)model[@"farm"] integerValue];
        NSInteger uniqueId =  [(NSNumber*)model[@"id"] integerValue];
        BOOL isFamily =  [(NSNumber*)model[@"isfamily"] integerValue];
        BOOL isFriend =  [(NSNumber*)model[@"isfamily"] integerValue];
        BOOL isPublic =  [(NSNumber*)model[@"isfamily"] integerValue];
        NSString *owner = (NSString*)model[@"owner"];
        NSString *server = (NSString*)model[@"server"];
        NSString *secret = (NSString*)model[@"secret"];
        NSString *title = (NSString*)model[@"title"];
        
        PhotoModel *photoModel = [[PhotoModel alloc]initWithFarm:farm uniqueId:uniqueId isFamily:isFamily isFriend:isFriend isPublic:isPublic owner:owner secret:secret server: server title:title];
        
        [photosArray addObject:photoModel];
  
        
    }
    
    FlickrWorkWithPhotoModel* model = [[FlickrWorkWithPhotoModel alloc] initWithTotal:total pagesAmount:pages pageNumber:page perPage:perPage photoModelArray: photosArray];
    
    return model;
    
}

@end
