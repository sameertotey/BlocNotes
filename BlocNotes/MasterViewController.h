//
//  MasterViewController.h
//  test
//
//  Created by Sameer Totey on 1/6/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"
#import "NotesDataSource.h"

@class DetailViewController;

@interface MasterViewController :  CoreDataTableViewController<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

