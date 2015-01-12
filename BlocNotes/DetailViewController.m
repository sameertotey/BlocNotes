//
//  DetailViewController.m
//  test
//
//  Created by Sameer Totey on 1/6/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setNote:(Note *)note {
    if (_note != note) {
        _note = note;
            
        // Update the view.
        [self configureView];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
}


@end
