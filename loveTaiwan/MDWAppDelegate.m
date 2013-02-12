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

@implementation MDWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSString *xmlData = [NSString stringWithContentsOfURL:[[NSURL alloc] initWithString: @"http://query.yahooapis.com/v1/public/yql/ming/a"] encoding:NSUTF8StringEncoding error:nil];
    if (nil != xmlData) {
        NSError *error = nil;
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithXMLString:xmlData options:0 error:&error];

        NSArray *items = [doc nodesForXPath:@"//query/results//font" error:nil];
        int count = 0;
        for(GDataXMLElement *item in items) {
#ifdef DEBUG
            NSLog(@"%s|(%d)%@",__PRETTY_FUNCTION__,count++,item.stringValue);
#endif
        }
    }
    
    
    //    }
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

@end
