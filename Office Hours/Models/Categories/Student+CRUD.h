//
//  Student+CRUD.h
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import "Student.h"
#import "LocalRepositoryAssistant.h"
#import "OfficeHoursConstants.h"

@interface Student (CRUD)

+ (Student *)createStudentWithFirstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName emailAddress:(NSString *)email username:(NSString *)username password:(NSString *)password phoneNumber:(NSString *)phoneNumber inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Student *)requestStudentWithUsername:(NSString *)username andPassword:(NSString *)password inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Student *)requestStudentWithFirstName:(NSString *)firstName middleName:(NSString *)middleName andLastName:(NSString *)lastName inManagedObjectContext:(NSManagedObjectContext *)context;

+ (Student *)requestStudentWithEmailAddress:(NSString *)emailAddress inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)updatePropertiesForStudent:(Student *)student withUsername:(NSString *)username password:(NSString *)password emailAddress:(NSString *)emailAddress phoneNumber:(NSString *)phoneNumber;

+ (void)deleteStudentWithEmailAddress:(NSString *)emailAddress inManagedObjectContext:(NSManagedObjectContext *)context;

@end
