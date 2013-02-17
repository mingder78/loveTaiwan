//
//  MDWDepartmentController.h
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/15.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Departments;

@interface MDWDepartmentController : NSObject {
@private
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    int *_doubleDigits;
}

@property int *doubleDigits;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (MDWDepartmentController *)getDefaultInstance;

- (void)saveContext;
- (Departments *)insertTitle: (NSString *)title;
- (NSArray *)fetchAllDepartments;
- (Departments *)findTitle:(NSString *)title;
- (Departments *)findDepartmentID:(NSString *)departmentID;
- (void) parseData:(NSArray *)data toDepartment:(Departments *)department schoolID:(int)i departmentID:(int)j;
@end
