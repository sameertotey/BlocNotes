//
//  MasterViewController.h
//  test
//
//  Created by Sameer Totey on 1/6/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotesDataTableViewController.h"

@class DetailViewController;

@interface MasterViewController :  NotesDataTableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

