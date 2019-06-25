//
//  InfoAboutOpenedPhotoViewController.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkLoadingServiceOutputProtocol.h"
#import "PhotoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface InfoAboutOpenedPhotoViewController : UIViewController <NetworkLoadingServiceOutputProtocol>

-(instancetype) initWithPhotoModel:(PhotoModel*) photoModel;


@end

NS_ASSUME_NONNULL_END
