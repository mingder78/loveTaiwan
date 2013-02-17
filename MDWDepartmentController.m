//
//  MDWDepartmentController.m
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/15.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import "MDWDepartmentController.h"
#import "Departments.h"
#import "GDataXMLNode.h"

@implementation MDWDepartmentController

#define LIST_MAX_DEPARTMENT {602,392,372,442,222,392,202,302,432,0,342,192,292,482,372,242,622,492,142,532,182,162,212,0,82,212,222,22,0,212,162,212,202,402,152,202,122,232,72,192,302,542,302,142,402,332,262,0,0,332,282,0,0,0,0,262,0,172,272,72,22,0,42,0,202,0,0,0,0,0,0,0,0,0,0,0,0,0,282,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,202,412,202,0,0,0,0,0,0,162,132,292,132,102,102,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,182,0,142,172,442,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,152,182,32,172}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

static MDWDepartmentController *instance;
#pragma mark - presistance database

- (void)saveContext {
    NSError *error = nil;
    @synchronized(self) {
        if(_managedObjectContext != nil) {
            if ([_managedObjectContext hasChanges] && ![_managedObjectContext save:&error]) {
                // Code to handle the error
                NSLog(@"Unresolved error %@, %@", error, [error localizedDescription]);// or [error UserInfo]
            }
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory]
                                               stringByAppendingPathComponent: @"Departments.sqlite"]];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil URL:storeURL options:nil error:&error]) {
        // Handle the error
        NSLog(@"Error %@, %@", error, [error userInfo]);
    }
    
    return _persistentStoreCoordinator;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"Departments" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

#pragma mark - singleton

+ (MDWDepartmentController *)getDefaultInstance
{
    @synchronized(self) {
        if (instance == nil){
            instance = [[MDWDepartmentController alloc] init];
            static int bufferDoubleDigits[154] = LIST_MAX_DEPARTMENT;
            instance.doubleDigits = bufferDoubleDigits;
        }
    }
    return instance;
}

#pragma mark - database operations

- (Departments *)insertTitle: (NSString *)title{
    Departments *object = [NSEntityDescription insertNewObjectForEntityForName:@"Departments"
                                                        inManagedObjectContext:[self managedObjectContext]];
    [object setTitle:title];
    return object;
}

- (NSArray *)fetchAllDepartments {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Departments" inManagedObjectContext:[self managedObjectContext]];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [[self managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"no data");
    } else {
        for (Departments *a in fetchedObjects) {
            NSLog(@"%@",a.title);
        }
#ifdef DEBUG
        NSLog(@"%s|%d",__PRETTY_FUNCTION__,fetchedObjects.count);
#endif
    }
    return fetchedObjects;
}

// return same title item or nil
- (Departments *)findTitle:(NSString *)title
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    request.entity = [NSEntityDescription entityForName:@"Departments" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"title = %@", title];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (nil != result && !error) {
        return [result lastObject];
    } else {
        return nil;
    }
}

// return same title item or nil
- (Departments *)findDepartmentID:(NSString *)departmentID
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [self managedObjectContext];
    request.entity = [NSEntityDescription entityForName:@"Departments" inManagedObjectContext:context];
    request.predicate = [NSPredicate predicateWithFormat:@"departmentID = %@", departmentID];
    
    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    if (result.count > 0 && !error) {
        return [result lastObject];
    } else {
        return nil;
    }
}

- (void) parseData:(NSArray *)data toDepartment:(Departments *)department schoolID:(int)i departmentID:(int)j
{
    department.schoolID = [NSString stringWithFormat:@"%03d", i];
    department.departmentID = [NSString stringWithFormat:@"%03d%03d", i, j];
#ifdef DEBUG
    NSLog(@"%s|%@",__PRETTY_FUNCTION__,department.title);
#endif
    for (int i = 0; i < data.count; i++) {
        NSString *element  = ((GDataXMLElement *)data[i]).stringValue;
        if ([element isEqualToString:@"國文"]) {
            department.chinese1 = ((GDataXMLElement *)data[++i]).stringValue;
            department.chinese2 = ((GDataXMLElement *)data[++i]).stringValue;
            department.chinese1 = ((GDataXMLElement *)data[++i]).stringValue;
        } else if ([element isEqualToString:@"英文"]) {
            department.english1 = ((GDataXMLElement *)data[++i]).stringValue;
            department.english2 = ((GDataXMLElement *)data[++i]).stringValue;
            department.english3 = ((GDataXMLElement *)data[++i]).stringValue;
        } else if ([element isEqualToString:@"數學"]) {
            department.math1 = ((GDataXMLElement *)data[++i]).stringValue;
            department.math2 = ((GDataXMLElement *)data[++i]).stringValue;
            department.math3 = ((GDataXMLElement *)data[++i]).stringValue;
        } else if ([element isEqualToString:@"社會"]) {
            department.social1 = ((GDataXMLElement *)data[++i]).stringValue;
            department.social2 = ((GDataXMLElement *)data[++i]).stringValue;
            department.social3 = ((GDataXMLElement *)data[++i]).stringValue;
        } else if ([element isEqualToString:@"自然"]) {
            department.nature1 = ((GDataXMLElement *)data[++i]).stringValue;
            department.nature2 = ((GDataXMLElement *)data[++i]).stringValue;
            department.nature3 = ((GDataXMLElement *)data[++i]).stringValue;
        } else if ([element isEqualToString:@"總級分"]) {
            department.total1 = ((GDataXMLElement *)data[++i]).stringValue;
            department.total2 = ((GDataXMLElement *)data[++i]).stringValue;
            department.total3 = ((GDataXMLElement *)data[++i]).stringValue;
        }
    }
}

- (int *)doubleDigits
{
    return _doubleDigits;
}
@end
