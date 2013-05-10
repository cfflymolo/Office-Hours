//
//  Section.h
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Department, Teacher;

@interface Section : NSManagedObject

@property (nonatomic, retain) NSString * classRoom;
@property (nonatomic, retain) NSString * daysInSession;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * identification;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * units;
@property (nonatomic, retain) Department *department;
@property (nonatomic, retain) Teacher *taughtBy;

@end
