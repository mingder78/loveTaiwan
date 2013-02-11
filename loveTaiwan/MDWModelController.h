//
//  MDWModelController.h
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/11.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDWDataViewController;

@interface MDWModelController : NSObject <UIPageViewControllerDataSource>

- (MDWDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(MDWDataViewController *)viewController;

@end
