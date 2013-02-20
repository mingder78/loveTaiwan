//
//  MDWDataViewController.m
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/11.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import "MDWDataViewController.h"
#import "MDWScoreLevel.h"

@interface MDWDataViewController ()

@end

@implementation MDWDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject title];
    self.chinese1.text = (NSString *)[self.dataObject chinese1];
    self.chinese2.text = (NSString *)[self.dataObject chinese2];
    self.chinese3.text = (NSString *)[self.dataObject chinese3];
    self.english1.text = (NSString *)[self.dataObject english1];
    self.english2.text = (NSString *)[self.dataObject english2];
    self.english3.text = (NSString *)[self.dataObject english3];
    self.math1.text = (NSString *)[self.dataObject math1];
    self.math2.text = (NSString *)[self.dataObject math2];
    self.math3.text = (NSString *)[self.dataObject math3];
    [MDWScoreLevel new];
    
}

@end
