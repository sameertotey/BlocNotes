//
//  ShowDetailViewController.m
//  BlocNotes
//
//  Created by Sameer Totey on 1/10/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "ShowDetailViewController.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailTextViewHeightConstraint;
@property (nonatomic)BOOL emptyNote;
@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self configureView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.emptyNote) {
        [self performSegueWithIdentifier:@"editDetail" sender:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
    self.emptyNote = NO;
    if (self.note) {
        if ([self.note.title length] || [self.note.detail length]) {
            self.title = @"Note Detail";
            self.titleLabel.text = self.note.title;
            self.detailTextView.text = self.note.detail;
        } else {
            self.emptyNote = YES;
        }
    } else {
        self.titleLabel.text = @"Welcome To BlocNotes!";
        self.detailTextView.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // we will adjust the height of the detail text view to fit its text
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.detailTextView.bounds) - 20, CGFLOAT_MAX);
    
    CGSize detailTextViewSize = [self.detailTextView sizeThatFits:self.detailTextView.bounds.size];
    

    // height should be a minimum of 60
    self.detailTextViewHeightConstraint.constant = detailTextViewSize.height > 60 ? detailTextViewSize.height : 60.0;
    [self.detailTextView scrollRangeToVisible:NSRangeFromString(self.detailTextView.text)];
}

- (IBAction)editNote:(UIBarButtonItem *)sender {
    NSLog(@"editNote");
    DetailViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Edit Detail View Controller"];
    controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    controller.navigationItem.leftItemsSupplementBackButton = YES;
    controller.note = self.note;
    [self.navigationController pushViewController:controller animated:YES];
 }


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"editDetail"]) {
        if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
            DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
            controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
            controller.navigationItem.leftItemsSupplementBackButton = YES;
            controller.note = self.note;
        }
    }
}

@end
