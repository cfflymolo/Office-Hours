//
//  Question.h
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Question : NSManagedObject

@property (nonatomic, retain) NSNumber * answered;
@property (nonatomic, retain) NSDate * submissionDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Student *askedBy;

@end
