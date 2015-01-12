//
//  SplitViewControllerDelegate.m
//  BlocNotes
//
//  Created by Sameer Totey on 1/10/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "SplitViewControllerDelegate.h"
#import "DetailViewController.h"

@implementation SplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController
{
    if ([secondaryViewController isKindOfClass:[UINavigationController class]]) {
        UIViewController *topSecondaryController = [(UINavigationController *)secondaryViewController topViewController];
        // if there is a note assigned to the
        if ([topSecondaryController isKindOfClass:[DetailViewController class]]) {
            if (((DetailViewController *)topSecondaryController).note) {
                return NO;
            }
        }
    }
    
    // The secondary view controller should be hidden - we override the defaul splitview controller to show the secondary view
    return YES;
}

//- (UIViewController *)splitViewController:(UISplitViewController *)splitViewController separateSecondaryViewControllerFromPrimaryViewController:(UIViewController *)primaryViewController
//{
//    return nil;
//    
//}


@end
