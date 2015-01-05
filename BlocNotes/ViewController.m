//
//  ViewController.m
//  BlocNotes
//
//  Created by Sameer Totey on 1/3/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Note.h"

@interface ViewController ()
@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.managedObjectContext = appDelegate.managedObjectContext;
//
//    Note *note = [NSEntityDescription
//                          insertNewObjectForEntityForName:@"Note"
//                          inManagedObjectContext:self.managedObjectContext];
//    NSString *date = [NSDate date].description;
//    note.title = [NSString stringWithFormat:@"Hello There %@", date];
    NSError *error;
//    if (![self.managedObjectContext save:&error]) {
//        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
//    }
//    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Note" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *info in fetchedObjects) {
        NSLog(@"Note: %@", [info valueForKey:@"title"]);
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
