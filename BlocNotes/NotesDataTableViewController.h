//
//  NotesDataTableViewController.h
//  BlocNotes
//
//  Created by Sameer Totey on 1/12/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import <CoreData/CoreData.h>
#import "CoreDataTableViewController.h"
#import "NotesDataSource.h"
#import "Note.h"

static NSString * const kCellIdentifier = @"NoteCell";

@interface NotesDataTableViewController : CoreDataTableViewController

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
