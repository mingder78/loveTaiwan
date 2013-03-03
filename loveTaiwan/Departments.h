//
//  Departments.h
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/3/3.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Departments : NSManagedObject

@property (nonatomic, retain) NSString * chinese1;
@property (nonatomic, retain) NSString * chinese2;
@property (nonatomic, retain) NSString * chinese3;
@property (nonatomic, retain) NSString * departmentID;
@property (nonatomic, retain) NSString * english1;
@property (nonatomic, retain) NSString * english2;
@property (nonatomic, retain) NSString * english3;
@property (nonatomic, retain) NSString * math1;
@property (nonatomic, retain) NSString * math2;
@property (nonatomic, retain) NSString * math3;
@property (nonatomic, retain) NSString * nature1;
@property (nonatomic, retain) NSString * nature2;
@property (nonatomic, retain) NSString * nature3;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSString * remarks;
@property (nonatomic, retain) NSString * reviewItems;
@property (nonatomic, retain) NSString * schoolID;
@property (nonatomic, retain) NSString * selecteItems;
@property (nonatomic, retain) NSString * social1;
@property (nonatomic, retain) NSString * social2;
@property (nonatomic, retain) NSString * social3;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * total1;
@property (nonatomic, retain) NSString * total2;
@property (nonatomic, retain) NSString * total3;
@property (nonatomic, retain) NSString * date;

@end
