//
//  NetworkAdditionalInfoService.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "NetworkAdditionalInfoService.h"
#import "NetworkHelper.h"

@interface NetworkAdditionalInfoService()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSData *resultData;

@end


@implementation NetworkAdditionalInfoService

-(void) flickrPhotoInfoWithUniqueId:(NSInteger) uniqueId
{
    //    if (self.urlSession.in)
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *urlString = [NetworkHelper URLForLoadingInfoWithUniqueId:uniqueId];
    [request setURL:[NSURL URLWithString: urlString]];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:15];
    
    NSURLSession *session;
    session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.resultData = data;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingIsDoneWithDataRecieved:self.resultData];
        });
    }];
    [sessionDataTask resume];
}


-(void) killCurrentTask
{
    
    [self.urlSession getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        for (NSURLSessionDataTask *dataTask in dataTasks)
        {
            [dataTask cancel];
        }
    }];
    //    [self.urlSession invalidateAndCancel];
    _resultData = [NSData new];
}

@end
