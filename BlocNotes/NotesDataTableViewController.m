//
//  NotesDataTableViewController.m
//  BlocNotes
//
//  Created by Sameer Totey on 1/12/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "NotesDataTableViewController.h"

@interface NotesDataTableViewController ()

@end

@implementation NotesDataTableViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView registerNib:[UINib nibWithNibName:@"TableCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
    self.debug = YES;
    [self registerForNotifications];
    self.managedObjectContext = [[NotesDataSource sharedInstance] managedObjectContext];
    [self setupFetchedResultsControllerWithPredicate:nil];
}

- (void)registerForNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(resetTheContext:)
                               name:kResetTheContext
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(refetchRequied:)
                               name:kRefetchRequired
                             object:nil];
    }

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)resetTheContext:(NSNotification *)notification {
    NSLog(@"[%@ %@] Reset the context received", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

- (void)refetchRequied:(NSNotification *)notification {
    NSLog(@"[%@ %@] Refetch", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    self.managedObjectContext = [[NotesDataSource sharedInstance] managedObjectContext];
    [self setupFetchedResultsControllerWithPredicate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupFetchedResultsControllerWithPredicate:(NSPredicate *)predicate {
    
    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    NSArray *sortDescriptors = @[titleDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // set the predicate
    [fetchRequest setPredicate:predicate];
    
    // Create and initialize the fetch results controller.
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
}


#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = note.detail;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
