//
//  MDWDataViewController.m
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/11.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import "MDWDataViewController.h"
#import "MDWScoreLevel.h"
#import "Departments.h"

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
    self.dataLabel.text = [((Departments *)self.dataObject) title];
    self.dataLabel2.text = [((Departments *)self.dataObject) departmentID];
    
    self.chinese1.text = (NSString *)[self.dataObject chinese1];
    self.chinese2.text = (NSString *)[self.dataObject chinese2];
    self.chinese3.text = (NSString *)[self.dataObject chinese3];
    self.english1.text = (NSString *)[self.dataObject english1];
    self.english2.text = (NSString *)[self.dataObject english2];
    self.english3.text = (NSString *)[self.dataObject english3];
    self.math1.text = (NSString *)[self.dataObject math1];
    self.math2.text = (NSString *)[self.dataObject math2];
    self.math3.text = (NSString *)[self.dataObject math3];
    self.social1.text = (NSString *)[self.dataObject social1];
    self.social2.text = (NSString *)[self.dataObject social2];
    self.social3.text = (NSString *)[self.dataObject social3];
    self.nature1.text = (NSString *)[self.dataObject nature1];
    self.nature2.text = (NSString *)[self.dataObject nature2];
    self.nature3.text = (NSString *)[self.dataObject nature3];
    self.total1.text = (NSString *)[self.dataObject total1];
    self.total2.text = (NSString *)[self.dataObject total2];
    self.total3.text = (NSString *)[self.dataObject total3];
    self.number.text = [NSString stringWithFormat:@"%@",((Departments *)self.dataObject).number];
    
    self.date.text = (NSString *)[self.dataObject date];

    [MDWScoreLevel new];
    
}

@end
