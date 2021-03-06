//
//  AppDelegate.m
//  BlocNotes
//
//  Created by Sameer Totey on 1/3/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TraitsOverrideViewController.h"
#import "SplitViewControllerDelegate.h"
@import BlocNotesKit;

@interface AppDelegate ()
@property (nonatomic, strong) SplitViewControllerDelegate *splitViewControllerDelegate;
@property (nonatomic, strong) NotesDataSource *notesDataSource;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Create the singleton notes data source object and configure it
    self.notesDataSource = [NotesDataSource sharedInstance];
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"BlocNotes.sqlite"];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BlocNotes" withExtension:@"momd"];
    NSDictionary *storeOptions = [self iCloudPersistentStoreOptions];
    [self.notesDataSource setupWithStoreURL:storeURL modelURL:modelURL storeOptions:storeOptions];

     UISplitViewController *splitViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Main Split View Controller"];
    
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    self.splitViewControllerDelegate = [[SplitViewControllerDelegate alloc] init];
    splitViewController.delegate = self.splitViewControllerDelegate;
   
    TraitsOverrideViewController *traitsOverrideViewController = (TraitsOverrideViewController *)self.window.rootViewController;
    traitsOverrideViewController.viewController = splitViewController;

    splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;

    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[NotesDataSource sharedInstance] saveContext];
}


# pragma mark - iCloud Support

/// Use these options in your call to -addPersistentStore:
- (NSDictionary *)iCloudPersistentStoreOptions {
    return @{NSPersistentStoreUbiquitousContentNameKey: @"BlocNotesAppCloudStore",
//             NSPersistentStoreUbiquitousContentURLKey:[self cloudDirectory],
            };
}

-(NSURL *)cloudDirectory
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *teamID=@"iCloud";
    NSString *bundleID=[[NSBundle mainBundle]bundleIdentifier];
    NSString *cloudRoot=[NSString stringWithFormat:@"%@.%@",teamID,bundleID];
    NSURL *cloudRootURL=[fileManager URLForUbiquityContainerIdentifier:cloudRoot];
    NSLog (@"cloudRootURL=%@",cloudRootURL);
    return cloudRootURL;
}

@end
