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

@implementation MDWAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    NSString *jsonData = [NSString stringWithContentsOfURL:[[NSURL alloc] initWithString: @"http://query.yahooapis.com/v1/public/yql/ming/td4"]
                                                  encoding:NSUTF8StringEncoding error:nil];
    if (nil != jsonData) {
#ifdef DEBUG
        NSLog(@"%s|%@",__PRETTY_FUNCTION__,jsonData);
#endif
        JSONDecoder* decoder = [[JSONDecoder alloc] init];
        NSDictionary *resultsDictionary = [decoder objectWithData:[jsonData dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSDictionary *items = [resultsDictionary objectForKey:@"query"];
        NSDictionary  *response = [items objectForKey:@"results"];
        
        NSArray *dataArray = [response objectForKey:@"font"];
        
        for (NSDictionary *item in dataArray) {
            NSLog(@"%@", [item objectForKey:@"content"]);
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

@end
