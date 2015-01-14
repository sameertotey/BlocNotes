//
//  ShareViewController.m
//  BlocNotesShareEx
//
//  Created by Sameer Totey on 1/9/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()
@property (nonatomic, strong)NotesDataSource *notesDataSource;
@end

@implementation ShareViewController

- (void)setupNotesDataSource {
    // Create the singleton notes data source object and configure it
    self.notesDataSource = [NotesDataSource sharedInstance];
    NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"BlocNotes.sqlite"];
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BlocNotes" withExtension:@"momd"];
    NSDictionary *storeOptions = [self iCloudPersistentStoreOptions];
    [self.notesDataSource setupWithStoreURL:storeURL modelURL:modelURL storeOptions:storeOptions];

}

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
    return YES;
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    [self setupNotesDataSource];
    
    NSExtensionItem *inputItem = self.extensionContext.inputItems.firstObject;
    
    NSManagedObjectContext *context = self.notesDataSource.managedObjectContext;
    Note *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];
    newNote.timeStamp = [NSDate date];
    NSString *title = [inputItem.attributedTitle string];
    if (!title) {
        title = NSStringFromClass([self class]);
    }
    newNote.title = title;
    newNote.detail = [inputItem.attributedContentText string];
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    NSExtensionItem *outputItem = [inputItem copy];
    outputItem.attributedContentText = [[NSAttributedString alloc] initWithString:self.contentText attributes:nil];

    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    [self.extensionContext completeRequestReturningItems:@[] completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return @[];
}

- (void)presentationAnimationDidFinish {
    NSLog(@"Presentation animation did finish");
}

- (void)didSelectCancel {
    NSLog(@"Did Select Cancel");
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
