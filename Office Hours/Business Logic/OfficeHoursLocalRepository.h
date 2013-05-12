//
//  OfficeHoursLocalRepository.h
//  Office Hours
//
//  Created by Robert Colin on 5/11/13.
//
//

#import <Foundation/Foundation.h>

#import "Student+CRUD.h"

@interface OfficeHoursLocalRepository : NSObject

@property (weak, readonly, nonatomic) UIManagedDocument *database;

+ (OfficeHoursLocalRepository *)sharedRepository;

- (Student *)createStudentWithFirstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName emailAddress:(NSString *)emailAddress username:(NSString *)username password:(NSString *)password phoneNumber:(NSString *)phoneNumber;
- (Student *)studentWithUsername:(NSString *)username;
- (Student *)studentWithEmailAddress:(NSString *)emailAddress;
- (void)updateStudentWithStudent:(Student *)student;

@end
