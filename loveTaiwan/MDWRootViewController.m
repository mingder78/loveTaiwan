//
//  MDWRootViewController.m
//  loveTaiwan
//
//  Created by Ming-der Wang on 13/2/11.
//  Copyright (c) 2013年 Ming-der Wang. All rights reserved.
//

#import "MDWRootViewController.h"

#import "MDWModelController.h"

#import "MDWDataViewController.h"
#import "MDWDepartmentController.h"

#import "JSONKit.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"
#import "SVProgressHUD.h"

@interface MDWRootViewController ()
@property (readonly, strong, nonatomic) MDWModelController *modelController;
@end

@implementation MDWRootViewController

@synthesize modelController = _modelController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self parse];
	// Do any additional setup after loading the view, typically from a nib.
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    MDWDataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];

    self.pageViewController.dataSource = self.modelController;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];

    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)parse
{
    NSMutableArray *doubleDigits = [NSMutableArray arrayWithCapacity:153];
    MDWDepartmentController *controller = [MDWDepartmentController getDefaultInstance];
    //    for (int i=1; i<154; i++) {
    //       [doubleDigits addObject:[NSNumber numberWithInt:controller.doubleDigits[i-1]]];
    //#ifdef DEBUG
    //        NSLog(@"%s|%@",__PRETTY_FUNCTION__,[NSNumber numberWithInt:controller.doubleDigits[i-1]]);
    //#endif
    //    }
    for (int i=1; i<154; i++) { //154
        
        
        //        int max = ((NSNumber *)doubleDigits[i-1]).intValue + 1;
        int max = controller.doubleDigits[i-1] + 1;
//        int count=0;
        for (int j=12; j < max; j=j+10) {
#ifdef DEBUG
            NSLog(@"%s|%d %d",__PRETTY_FUNCTION__,max, j);
#endif
            [self getDataForSchoolID:i departmentID:j];
//            [self performSelectorOnMainThread:@selector(showHUD:) withObject:[NSNumber numberWithInteger:count++] waitUntilDone:NO];
        }
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MDWModelController *)modelController
{
     // Return the model controller object, creating it if necessary.
     // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[MDWModelController alloc] init];
    }
    return _modelController;
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }

    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    MDWDataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;

    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];


    return UIPageViewControllerSpineLocationMid;
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
