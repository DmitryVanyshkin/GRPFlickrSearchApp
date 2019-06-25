//
//  PhotoCollectionViewCell.h
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell

-(instancetype) initWithFrame:(CGRect)frame;
-(void) setImageForImageView : (UIImage*) image;
-(void) setStrokeEnd:(CGFloat)strokeEnd;

@end

NS_ASSUME_NONNULL_END
