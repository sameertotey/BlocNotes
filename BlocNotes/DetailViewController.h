//
//  DetailViewController.h
//  test
//
//  Created by Sameer Totey on 1/6/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Note *note;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

