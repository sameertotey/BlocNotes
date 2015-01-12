//
//  TraitsOverrideViewController.m
//  BlocNotes
//
//  The purpose of this view controller is to provide a container for the view hierarchy of the app and override trait collections when needed
//  Created by Sameer Totey on 1/8/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "TraitsOverrideViewController.h"

@interface TraitsOverrideViewController ()
@property (copy, nonatomic) UITraitCollection *forcedTraitCollection;

@end

@implementation TraitsOverrideViewController
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    // There is an issue with overriding traits of a view controller and core data, if I try to override the traits of the split view controller after performing updates on core data it crashes. So will disable traits overriding for now
//    if (size.width > 320.0) {
    // increased the width  to accomodate iPhone6 & iPhone6 plus
//    if (size.width > 414.0) {
//          // If we are large enough, force a regular size class
//        self.forcedTraitCollection = [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassRegular];
//    } else {
//        // Otherwise, don't override any traits
//        self.forcedTraitCollection = nil;
//    }
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (void)updateForcedTraitCollection
{
    // Use our forcedTraitCollection to override our child's traits
    [self setOverrideTraitCollection:self.forcedTraitCollection forChildViewController:self.viewController];
}



- (void)setViewController:(UIViewController *)viewController
{
    if (_viewController != viewController) {
        if (_viewController) {
            [_viewController willMoveToParentViewController:nil];
            [self setOverrideTraitCollection:nil forChildViewController:_viewController];
            [_viewController.view removeFromSuperview];
            [_viewController removeFromParentViewController];
        }
        
        if (viewController) {
            [self addChildViewController:viewController];
        }
        _viewController = viewController;
        
        if (_viewController) {
            UIView *view = _viewController.view;
            view.translatesAutoresizingMaskIntoConstraints = NO;
            [self.view addSubview:view];
            NSDictionary *views = NSDictionaryOfVariableBindings(view);
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[view]|" options:0 metrics:nil views:views]];
            [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:views]];
            [_viewController didMoveToParentViewController:self];
            
            [self updateForcedTraitCollection];
        }
    }
}

- (void)setForcedTraitCollection:(UITraitCollection *)forcedTraitCollection
{
    if (_forcedTraitCollection != forcedTraitCollection) {
        _forcedTraitCollection = [forcedTraitCollection copy];
        [self updateForcedTraitCollection];
    }
}

- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return YES;
}

- (BOOL)shouldAutomaticallyForwardRotationMethods
{
    return YES;
}

@end
