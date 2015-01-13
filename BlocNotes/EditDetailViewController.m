//
//  EditDetailViewController.m
//  BlocNotes
//
//  Created by Sameer Totey on 1/10/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "EditDetailViewController.h"

@interface EditDetailViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailTextViewHeightConstraint;

@end

@implementation EditDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configureView {
    // Update the user interface for the detail item.
    if (self.note) {
        if ([self.note.title length] || [self.note.detail length]) {
            self.title = @"Edit Note";
            self.titleTextField.text = self.note.title;
            self.detailTextView.text = self.note.detail;
        } else {
            self.title = @"Edit New Note";
        }
    } else {
        NSLog(@"Should not have reached here in edit view without note,through any flows");
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // we will adjust the height of the detail text view to fit its text
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.detailTextView.frame) - 20, CGFLOAT_MAX);
    
    CGSize detailTextViewSize = [self.detailTextView sizeThatFits:maxSize];
    
    // height should be a minimum of 60
    self.detailTextViewHeightConstraint.constant = detailTextViewSize.height > 60 ? detailTextViewSize.height : 60.0;
    [self.detailTextView scrollRangeToVisible:NSRangeFromString(self.detailTextView.text)];
}

- (IBAction)doneAction:(UIBarButtonItem *)sender {
    [self saveNote];
//    [self performSegueWithIdentifier:@"showDetailAfterEdit" sender:nil];
    [self.navigationController popViewControllerAnimated:YES];
 }

- (void)saveNote {
    NSManagedObjectContext *context = [self.note managedObjectContext];
    if (context) {
        self.note.title = self.titleTextField.text;
        self.note.detail = self.detailTextView.text;
        self.note.timeStamp = [NSDate date];

        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - TextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self resignFirstResponder];
    [self saveNote];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self saveNote];
    return YES;
}

#pragma mark - TextViewDelegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    // we do not want to erase the existing contents here, but show done and cancel button to end editing
    self.navigationItem.rightBarButtonItems = @[self.doneButton];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self saveNote];
}

- (void)textViewDidChange:(UITextView *)textView {
    [self saveNote];
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}

- (void)doneEditing {
    [self.detailTextView resignFirstResponder];
    [self saveNote];
}

- (void)cancelEditing {
    
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetailAfterEdit"]) {
        if ([segue.destinationViewController isKindOfClass:[UINavigationController class]]) {
            DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
            controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            controller.navigationItem.leftItemsSupplementBackButton = YES;
            controller.note = self.note;
        }
    }
}

@end
