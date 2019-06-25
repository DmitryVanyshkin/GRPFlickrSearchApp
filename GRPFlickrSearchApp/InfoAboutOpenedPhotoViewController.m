//
//  InfoAboutOpenedPhotoViewController.m
//  GRPFlickrSearchApp
//
//  Created by Дмитрий Ванюшкин on 25/06/2019.
//  Copyright © 2019 Dmitry Vanyushkin. All rights reserved.
//

#import "InfoAboutOpenedPhotoViewController.h"
#import "NetworkAdditionalInfoService.h"
#import "ConvertNSDataToFullPhotoModel.h"
#import "FullPhotoModel.h"

@interface InfoAboutOpenedPhotoViewController ()

@property (nonatomic, strong) PhotoModel *photoModel;
@property (nonatomic, strong) FullPhotoModel *fullPhotoModel;
@property (nonatomic, strong) UIImageView *photoView;
@property (nonatomic, strong) NetworkAdditionalInfoService *additionalInfoService;

@property (nonatomic, strong) UIStackView *stackView;
@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *dateOfPublicationLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *locationLabel;

@end

@implementation InfoAboutOpenedPhotoViewController

-(instancetype) initWithPhotoModel:(PhotoModel*) photoModel
{
    self = [super init];
    
    if (self)
    {
        _photoModel = [PhotoModel new];
        _photoModel = photoModel;
        _photoView = [UIImageView new];
        _additionalInfoService = [NetworkAdditionalInfoService new];
        
        _authorNameLabel = [UILabel new];
        _titleLabel = [UILabel new];
        _dateOfPublicationLabel = [UILabel new];
        _locationLabel = [UILabel new];
        _descriptionLabel = [UILabel new];
        
        _stackView = [UIStackView new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoView.image = self.photoModel.image;
    
    
    self.additionalInfoService.output = self;
    [self.additionalInfoService flickrPhotoInfoWithUniqueId:self.photoModel.uniqueId];
    
    self.descriptionLabel.numberOfLines = 0;
    
    [self.view addSubview:self.photoView];
    
    
    
    
    [self setupStackView];
    [self setConstraints];
    // Do any additional setup after loading the view.
}

-(void) setupStackView
{
    self.stackView = [[UIStackView alloc] initWithArrangedSubviews: [NSArray arrayWithObjects:self.titleLabel, self.locationLabel, self.descriptionLabel, self.authorNameLabel, nil]];
    [self.view addSubview:self.stackView];
    self.stackView.alignment = UIStackViewAlignmentFill;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.spacing = 20;
//    [self.stackView addSubview:self.titleLabel];
//    [self.stackView addSubview:self.locationLabel];
//    [self.stackView addSubview:self.descriptionLabel];
//    [self.stackView addSubview:self.authorNameLabel];
}

-(void) setConstraints
{
    self.photoView.translatesAutoresizingMaskIntoConstraints = NO;
//    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.locationLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.authorNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.photoView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.photoView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor].active = YES;
    [self.photoView.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width].active = YES;
    [self.photoView.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width].active = YES;
    
    [self.stackView.topAnchor constraintEqualToAnchor:self.photoView.bottomAnchor constant:10].active = YES;
    [self.stackView.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:10].active = YES;
    [self.stackView.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-10].active = YES;
    [self.stackView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    
//    [self.titleLabel.topAnchor constraintEqualToAnchor:self.photoView.bottomAnchor constant:10].active = YES;
//    [self.titleLabel.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:10].active = YES;
//    [self.titleLabel.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-10].active = YES;
//
//    [self.locationLabel.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:10].active = YES;
//    [self.locationLabel.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:10].active = YES;
//    [self.locationLabel.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-10].active = YES;
//
//    [self.descriptionLabel.topAnchor constraintEqualToAnchor:self.locationLabel.bottomAnchor constant:10].active = YES;
//    [self.descriptionLabel.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:10].active = YES;
//    [self.descriptionLabel.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-10].active = YES;
//    [self.descriptionLabel.bottomAnchor constraintEqualToAnchor:self.authorNameLabel.topAnchor].active = YES;
//
//    [self.authorNameLabel.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:10].active = YES;
//    [self.authorNameLabel.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-10].active = YES;
//    [self.authorNameLabel.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor].active = YES;
    

}

-(void) loadingIsDoneWithDataRecieved:(NSData *)dataRecieved
{
    if (dataRecieved)
    {
        ConvertNSDataToFullPhotoModel *converter = [ConvertNSDataToFullPhotoModel new];
        
        FullPhotoModel *model = [FullPhotoModel new];
        model = [converter convertToModelFromNSData:dataRecieved];
        self.fullPhotoModel = model;
        
        [self updateInfo];
    }
    else
    {
        UIAlertController *connectionAlert = [UIAlertController alertControllerWithTitle:@"Bad news" message:@"Check Internet connection" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        [connectionAlert addAction:action];
        
        [self presentViewController:connectionAlert animated:YES completion:nil];
    }
    
    
}

-(void)updateInfo
{
    self.titleLabel.text = [NSString stringWithFormat:@"%@", self.fullPhotoModel.title];

    NSDate *publicationDate = self.fullPhotoModel.postDate;
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = NSDateFormatterMediumStyle;
    NSString *dateString = [formatter stringFromDate:publicationDate];
    
    
    self.locationLabel.text = [NSString stringWithFormat:@"%@ %@", self.fullPhotoModel.location, dateString];
    
    
    self.authorNameLabel.text = [NSString stringWithFormat:@"Author: %@", self.fullPhotoModel.author];
    
    
    if (self.fullPhotoModel.desrciption.length > 0)
    {
        self.descriptionLabel.text = [NSString stringWithFormat:@"%@", self.fullPhotoModel.desrciption];
    }
    else
    {
        self.descriptionLabel.text = @"Author didn't provide any info";
    }
    
    
    
}


@end
