//
//  MDWDataViewController.h
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/11.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDWDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UILabel *dataLabel2;
@property (strong, nonatomic) IBOutlet UILabel *date;

@property (strong, nonatomic) IBOutlet UILabel *chinese1;
@property (strong, nonatomic) IBOutlet UILabel *chinese2;
@property (strong, nonatomic) IBOutlet UILabel *chinese3;

@property (strong, nonatomic) IBOutlet UILabel *english1;
@property (strong, nonatomic) IBOutlet UILabel *english2;
@property (strong, nonatomic) IBOutlet UILabel *english3;

@property (strong, nonatomic) IBOutlet UILabel *math1;
@property (strong, nonatomic) IBOutlet UILabel *math2;
@property (strong, nonatomic) IBOutlet UILabel *math3;

@property (strong, nonatomic) IBOutlet UILabel *social1;
@property (strong, nonatomic) IBOutlet UILabel *social2;
@property (strong, nonatomic) IBOutlet UILabel *social3;

@property (strong, nonatomic) IBOutlet UILabel *nature1;
@property (strong, nonatomic) IBOutlet UILabel *nature2;
@property (strong, nonatomic) IBOutlet UILabel *nature3;

@property (strong, nonatomic) IBOutlet UILabel *total1;
@property (strong, nonatomic) IBOutlet UILabel *total2;
@property (strong, nonatomic) IBOutlet UILabel *total3;

@property (strong, nonatomic) IBOutlet UILabel *number;

@property (strong, nonatomic) id dataObject;

@end
