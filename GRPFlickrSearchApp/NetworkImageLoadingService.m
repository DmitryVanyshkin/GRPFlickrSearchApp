//
//  NetworkImageLoadingService.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "NetworkImageLoadingService.h"
#import "NetworkHelper.h"

@interface NetworkImageLoadingService()

@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSMutableDictionary<NSNumber*, NSURLSessionDownloadTask*> *downloadTaskDictionary;


@end


@implementation NetworkImageLoadingService

-(void) configureUrlSessionWithParams:(NSDictionary *)params
{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Настравиваем Session Configuration
    [sessionConfiguration setAllowsCellularAccess:YES];
    if (params)
    {
        [sessionConfiguration setHTTPAdditionalHeaders:params];//@{ @"Accept" : @"application/json" }];
    }
    else
    {
        [sessionConfiguration setHTTPAdditionalHeaders:@{ @"Accept" : @"application/json" }];
    }
    
    // Создаем сессию
    self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
}

-(void)startLoadingImageForId: (NSInteger)uniqueId farm:(NSInteger) farm server:(NSString*) server
secret: (NSString*) secret at: (NSInteger) index
{
    if (!self.urlSession)
    {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    
    NSURL *urlToDownLoad = [NSURL URLWithString:[NetworkHelper URLForLoadingImagesWithUniqueId:uniqueId farm:farm server:server secret:secret]];

    NSURLSessionDownloadTask *downloadTask = [self.urlSession downloadTaskWithURL:urlToDownLoad];
    
    @synchronized (self.downloadTaskDictionary) {
        if (!self.downloadTaskDictionary)
        {
            self.downloadTaskDictionary = [NSMutableDictionary new];
        }
        
        [self.downloadTaskDictionary setObject:downloadTask forKey:[NSNumber numberWithInteger:index]];
    }
    
    [downloadTask resume];
    
}

- (void)URLSession:(nonnull NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location
{
    
    @synchronized (self.downloadTaskDictionary) {
        NSInteger index = [[self.downloadTaskDictionary allKeysForObject:downloadTask] firstObject].integerValue;
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingIsDoneWithDataRecieved:data at:index];
        });
    }
    
    
    
    //[session finishTasksAndInvalidate];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    @synchronized (self.downloadTaskDictionary) {
        NSInteger index = [[self.downloadTaskDictionary allKeysForObject:downloadTask] firstObject].integerValue;
        
        double progress = (double)bytesWritten/(double)totalBytesWritten;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.output loadingContinuesWithProgress:progress at:index];
        });
    }
    
    
    
}

-(void) killCurentTask
{
    [self.urlSession getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        for (NSURLSessionDataTask *downloadTask in downloadTasks)
        {
            [downloadTask cancel];
        }
    }];
//    [self.urlSession invalidateAndCancel];
    _downloadTaskDictionary = [NSMutableDictionary new];
}

@end
