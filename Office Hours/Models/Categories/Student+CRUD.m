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
                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSDictionary *parameters = @{FIRST_NAME: firstName, MIDDLE_NAME: middleName, LAST_NAME: lastName,
                                 EMAIL_ADDRESS: email, PASSWORD: password, PHONE_NUMBER: phoneNumber,
                                 USERNAME: username};
    NSArray *students = [LocalRepositoryAssistant performDatabaseFetchRequestForClass:self.class
                                                                       withParameters:parameters
                                                               inManagedObjectContext:context];
    Student *student;
    
    if (!students.count) {
        // Create student
        student = (Student *)[LocalRepositoryAssistant createManagedObjectForClass:self.class
                                                                    withParameters:parameters
                                                            inManagedObjectContext:context];
    } else if (students.count == 1) {
        // Update student record
        student = (Student *)[students lastObject];
        [self updatePropertiesForStudent:student
                            withUsername:username
                                password:password
                            emailAddress:email
                             phoneNumber:phoneNumber];
    } else {
        // Error happened here
        NSLog(@"%@ createStudent Error", self.class);
    }
    
    return student;
}

+ (Student *)requestStudentWithUsername:(NSString *)username
                            andPassword:(NSString *)password
                 inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSDictionary *parameters = @{USERNAME: username, PASSWORD: password};
    NSArray *students = [LocalRepositoryAssistant performDatabaseFetchRequestForClass:self.class
                                                                       withParameters:parameters
                                                               inManagedObjectContext:context];
    Student *student = nil;
    
    if (students.count == 1) {
        student = (Student *)[students lastObject];
    }
    
    return student;
}

+ (Student *)requestStudentWithFirstName:(NSString *)firstName
                              middleName:(NSString *)middleName
                             andLastName:(NSString *)lastName
                  inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSDictionary *parameters = @{FIRST_NAME: firstName, MIDDLE_NAME: middleName, LAST_NAME: lastName};
    NSArray *students = [LocalRepositoryAssistant performDatabaseFetchRequestForClass:self.class
                                                                       withParameters:parameters
                                                               inManagedObjectContext:context];
    Student *student = nil;
    
    if (students.count == 1) {
        student = (Student *)[students lastObject];
    }
    
    return student;
}

+ (Student *)requestStudentWithEmailAddress:(NSString *)emailAddress
                     inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSDictionary *parameters = @{EMAIL_ADDRESS: emailAddress};
    NSArray *students = [LocalRepositoryAssistant performDatabaseFetchRequestForClass:self.class
                                                                       withParameters:parameters
                                                               inManagedObjectContext:context];
    Student *student = nil;
    
    if (students.count == 1) {
        student = (Student *)[students lastObject];
    }
    
    return student;
}

+ (void)updatePropertiesForStudent:(Student *)student
                      withUsername:(NSString *)username
                          password:(NSString *)password
                      emailAddress:(NSString *)emailAddress
                       phoneNumber:(NSString *)phoneNumber
{
    student.username = username;
    student.password = password;
    student.email = emailAddress;
    student.phoneNumber = phoneNumber;
}

+ (void)deleteStudentWithEmailAddress:(NSString *)emailAddress inManagedObjectContext:(NSManagedObjectContext *)context
{
    Student *student = [self requestStudentWithEmailAddress:emailAddress
                                     inManagedObjectContext:context];
    [context deleteObject:student];
    [LocalRepositoryAssistant saveChangesToContext:context];
}

@end
