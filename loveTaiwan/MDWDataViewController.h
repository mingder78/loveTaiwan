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

@property (strong, nonatomic) IBOutlet UILabel *chinese1;
@property (strong, nonatomic) IBOutlet UILabel *chinese2;
@property (strong, nonatomic) IBOutlet UILabel *chinese3;

@property (strong, nonatomic) IBOutlet UILabel *english1;
@property (strong, nonatomic) IBOutlet UILabel *english2;
@property (strong, nonatomic) IBOutlet UILabel *english3;

@property (strong, nonatomic) IBOutlet UILabel *math1;
@property (strong, nonatomic) IBOutlet UILabel *math2;
@property (strong, nonatomic) IBOutlet UILabel *math3;

@property (strong, nonatomic) id dataObject;

@end
