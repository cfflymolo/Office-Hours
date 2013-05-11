//
//  Student.h
//  Office Hours
//
//  Created by Robert Colin on 5/11/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Question, Section;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * middleName;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *questions;
@property (nonatomic, retain) NSSet *enrolledIn;
@end

@interface Student (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(Question *)value;
- (void)removeQuestionsObject:(Question *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

- (void)addEnrolledInObject:(Section *)value;
- (void)removeEnrolledInObject:(Section *)value;
- (void)addEnrolledIn:(NSSet *)values;
- (void)removeEnrolledIn:(NSSet *)values;

@end
