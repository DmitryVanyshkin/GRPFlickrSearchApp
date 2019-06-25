//
//  ViewController.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 23/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "ViewController.h"
#import "NetworkFlickrSearchingService.h"
#import "NetworkImageLoadingService.h"
#import "PhotoCollectionViewCell.h"
#import "ConvertNSDataToPhotoModel.h"
#import "FlickrWorkWithPhotoModel.h"
#import "InfoAboutOpenedPhotoViewController.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, NetworkLoadingServiceOutputProtocol>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *photoCollectionView;
@property (nonatomic, strong) NetworkFlickrSearchingService *searchService;
@property (nonatomic, strong) NetworkImageLoadingService *imageLoadService;
@property (nonatomic, strong) FlickrWorkWithPhotoModel *photoModel;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectZero];
    self.searchBar.delegate = self;
    
    self.searchService = [NetworkFlickrSearchingService new];
    self.imageLoadService = [NetworkImageLoadingService new];
 
    
    self.searchService.output = self;
    self.imageLoadService.output = self;
    
    [self.view addSubview:self.searchBar];
    [self setupPhotoCollection];
    [self setConstraints];
//    [self.searchService findFlickrPhotosWithSearchString:@"Earth"];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    
}

-(void) setupPhotoCollection
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.photoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.photoCollectionView registerClass:PhotoCollectionViewCell.class forCellWithReuseIdentifier:@"PhotoCell"];
    
    self.photoCollectionView.delegate = self;
    self.photoCollectionView.dataSource = self;
    
    self.photoCollectionView.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.photoCollectionView];
}

-(void) setConstraints
{
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.photoCollectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.searchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.searchBar.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.searchBar.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    
    [self.photoCollectionView.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor].active = YES;
    [self.photoCollectionView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.photoCollectionView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor].active = YES;
    [self.photoCollectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    if (self.photoModel.photoModelArray.count > indexPath.row)
    {
        PhotoModel *currentModel = self.photoModel.photoModelArray[indexPath.row];
        
        [cell setStrokeEnd:currentModel.loadProgress];
        
        
        if (!currentModel.image)
        {
            NSNumber *uniqueId = [NSNumber numberWithUnsignedInteger:currentModel.uniqueId];
            NSNumber *farm = [NSNumber numberWithUnsignedInteger:currentModel.farm];
            NSString *server = currentModel.server;
            NSString *secret = currentModel.secret;
            
            [self.imageLoadService startLoadingImageForId:[uniqueId integerValue] farm:[farm integerValue] server:server secret:secret at:indexPath.row];
        }
        else
        {
            [cell setImageForImageView:currentModel.image];
        }

        
    }
    
    else if (indexPath.row % self.photoModel.perPage == 0)
    {
        [self.searchService findFlickrPhotosWithSearchString:self.searchBar.text forPage:indexPath.row / self.photoModel.perPage ];
    }
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.photoModel.photoModelArray.count > indexPath.row)
    {
        PhotoModel *currentModel = self.photoModel.photoModelArray[indexPath.row];
        
        if (currentModel.image)
        {
            InfoAboutOpenedPhotoViewController* vc = [[InfoAboutOpenedPhotoViewController alloc]initWithPhotoModel:currentModel];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.photoModel)
    {
        return self.photoModel.total;
    }
    else
    {
        return 0;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    CGSize size = CGSizeMake(width / 3, width/3);
    
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(void) loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    
    if (dataRecieved != nil)
    {
   
        ConvertNSDataToPhotoModel* converter = [ConvertNSDataToPhotoModel new];
        
        FlickrWorkWithPhotoModel *newLoadedModel = [converter convertNSData:dataRecieved];
        
        if (!self.photoModel)
        {
            self.photoModel = [FlickrWorkWithPhotoModel new];
            self.photoModel = newLoadedModel;
            
        }
        else
        {
            [self.photoModel.photoModelArray addObjectsFromArray:newLoadedModel.photoModelArray];
        }
        
        
        [self.photoCollectionView reloadData];

    }
    
}

-(void) loadingIsDoneWithDataRecieved:(NSData *)dataRecieved at:(NSInteger)index
{
    
    if (dataRecieved)
    {
        
        UIImage *image = [UIImage imageWithData: dataRecieved];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        
        [self.photoModel setImageForObjectAtIndex:index image:image];
        
        PhotoCollectionViewCell *cell = [self.photoCollectionView cellForItemAtIndexPath:indexPath];
        
        if (cell)
        {
            [cell setImageForImageView:image];
        }
    }
    else
    {
        UIAlertController *connectionAlert = [UIAlertController alertControllerWithTitle:@"Bad news" message:@"Check Internet connection" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [connectionAlert addAction:action];
        
        [self presentViewController:connectionAlert animated:YES completion:nil];
    }
    
}

-(void) loadingContinuesWithProgress:(double)progress at:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    PhotoCollectionViewCell *cell = [self.photoCollectionView cellForItemAtIndexPath:indexPath];
    
    if (cell)
    {
        [cell setStrokeEnd:progress];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchService killCurrentTask];
    [self.imageLoadService killCurentTask];
    _photoModel = nil;
    [_photoCollectionView reloadData];
    [self.searchService findFlickrPhotosWithSearchString:searchBar.text];
    
    
}

@end
