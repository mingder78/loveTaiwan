//
//  MDWAppDelegate.m
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/11.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import "MDWAppDelegate.h"
#import "JSONKit.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"

#import "MDWDepartmentController.h"

@implementation MDWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSMutableArray *doubleDigits = [NSMutableArray arrayWithCapacity:153];
    MDWDepartmentController *controller = [MDWDepartmentController getDefaultInstance];
    //    for (int i=1; i<154; i++) {
    //       [doubleDigits addObject:[NSNumber numberWithInt:controller.doubleDigits[i-1]]];
    //#ifdef DEBUG
    //        NSLog(@"%s|%@",__PRETTY_FUNCTION__,[NSNumber numberWithInt:controller.doubleDigits[i-1]]);
    //#endif
    //    }
    for (int i=1; i<51; i++) { //154
        
        
        //        int max = ((NSNumber *)doubleDigits[i-1]).intValue + 1;
        int max = controller.doubleDigits[i-1] + 1;
        for (int j=12; j < max; j=j+10) {
#ifdef DEBUG
            NSLog(@"%s|%d %d",__PRETTY_FUNCTION__,max, j);
#endif
            [self getDataForSchoolID:i departmentID:j];
        }
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - internal methods

- (void) getDataForSchoolID: (int) i departmentID: (int) j
{
    MDWDepartmentController *controller = [MDWDepartmentController getDefaultInstance];
    if([controller findDepartmentID:[NSString stringWithFormat:@"%03d%03d",i,j]]) {
        return;
    }
    NSString *urlstr = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?q=select * from html where url = \"https://www.caac.ccu.edu.tw/caac102/102ad_ColgtQrym/html/102_%03d%03d.htm\" and xpath = \"//table\"", i, j];
    
    urlstr = [urlstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *xmlData = [NSString stringWithContentsOfURL:[[NSURL alloc] initWithString: urlstr] encoding:NSUTF8StringEncoding error:nil];
    
    NSError *error = nil;
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:xmlData options:0 error:&error];
    if (!error) {
        NSArray *data = [doc nodesForXPath:@"//query/results//font" error:&error];
        if (data.count != 0 && !error) {
            NSString *title = ((GDataXMLElement *)data[0]).stringValue;
            
            Departments *depart = [controller findTitle:title];
            
            if (!depart) {
                depart = [controller insertTitle:title];
            }
            [controller parseData:data toDepartment:depart schoolID:i departmentID:j];
            [controller saveContext];
        }
    }
}

@end
