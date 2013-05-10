//
//  Office.h
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Teacher;

@interface Office : NSManagedObject

@property (nonatomic, retain) NSString * building;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * roomNumber;
@property (nonatomic, retain) Teacher *teacher;

@end
