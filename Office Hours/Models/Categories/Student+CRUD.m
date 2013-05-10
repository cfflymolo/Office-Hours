//
//  Student+CRUD.m
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import "Student+CRUD.h"

@implementation Student (CRUD)

+ (Student *)createStudentWithFirstName:(NSString *)firstName
                             middleName:(NSString *)middleName
                               lastName:(NSString *)lastName
                           emailAddress:(NSString *)email
                               username:(NSString *)username
                               password:(NSString *)password
                            phoneNumber:(NSString *)phoneNumber
{
    NSArray *students;
    Student *student;
    
    if (!students.count) {
        // Create student
    } else if (students.count == 1) {
        // Update student record
    } else {
        // Error happened here
    }
    
    return student;
}

@end
