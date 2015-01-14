//
//  NotesDataSource.h
//  BlocNotes
//
//  Created by Sameer Totey on 1/8/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

static NSString * const kResetTheContext = @"ManagedObjectContextReset";
static NSString * const kRefetchRequired = @"ManagedObjectContextRefetchRequied";

@interface NotesDataSource : NSObject
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

- (void)setupWithStoreURL:storeURL modelURL:modelURL storeOptions:storeOptions;
+ (instancetype)sharedInstance;

@end
