//
//  Note.h
//  BlocNotes
//
//  Created by Sameer Totey on 1/8/15.
//  Copyright (c) 2015 Sameer Totey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * detail;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSNumber * complete;

@end
