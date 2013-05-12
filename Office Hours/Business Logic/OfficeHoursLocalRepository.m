//
//  OfficeHoursLocalRepository.m
//  Office Hours
//
//  Created by Robert Colin on 5/11/13.
//
//

#import "OfficeHoursLocalRepository.h"

@interface OfficeHoursLocalRepository ()
@property (strong, nonatomic) UIManagedDocument *officeHoursRepository;
@end

@implementation OfficeHoursLocalRepository

#pragma mark - Debug Methods

- (void)debugCreateTemporaryStudents
{
    [Student createStudentWithFirstName:@"Robert"
                             middleName:@"Daniel"
                               lastName:@"Colin"
                           emailAddress:@"email@email.com"
                               username:@"rcolin"
                               password:@"password123"
                            phoneNumber:@"11234567890"
                 inManagedObjectContext:OfficeHoursLocalRepository.sharedRepository.database.managedObjectContext];
}

- (void)debugCreateTemporaryTeachers
{
    
}

#pragma mark - Office Hours Repository Methods

+ (OfficeHoursLocalRepository *)sharedRepository
{
    static OfficeHoursLocalRepository *_sharedOfficeRepository;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedOfficeRepository = [[OfficeHoursLocalRepository allocWithZone:nil] init];
    });
    return _sharedOfficeRepository;
}

- (id)init
{
    if ((self = [super init])) {
        if (!self.officeHoursRepository) {
            NSURL *url = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory
                                                               inDomains:NSUserDomainMask] lastObject];
            url = [url URLByAppendingPathComponent:@"OfficeHoursRepository"];
            self.officeHoursRepository = [[UIManagedDocument alloc] initWithFileURL:url];
        } else {
            [self useOfficeRepository];
        }
    }
    
    return self;
}

- (void)setOfficeHoursRepository:(UIManagedDocument *)officeHoursRepository
{
    if (_officeHoursRepository != officeHoursRepository) {
        _officeHoursRepository = officeHoursRepository;
        [self useOfficeRepository];
    }
}

- (void)useOfficeRepository
{
    if (![NSFileManager.defaultManager fileExistsAtPath:self.officeHoursRepository.fileURL.path]) {
        [self.officeHoursRepository saveToURL:self.officeHoursRepository.fileURL
                             forSaveOperation:UIDocumentSaveForCreating
                            completionHandler:^(BOOL success) {
                                [self debugCreateTemporaryStudents];
                            }];
    } else if ([self.officeHoursRepository documentState] == UIDocumentStateClosed) {
        [self.officeHoursRepository openWithCompletionHandler:^(BOOL success) {
            NSLog(@"Office hours database is now ready");
        }];
    }
}

#pragma mark - Student Related Methods

- (Student *)createStudentWithFirstName:(NSString *)firstName
                             middleName:(NSString *)middleName
                               lastName:(NSString *)lastName
                           emailAddress:(NSString *)emailAddress
                               username:(NSString *)username
                               password:(NSString *)password
                            phoneNumber:(NSString *)phoneNumber
{
    return [Student createStudentWithFirstName:firstName
                                    middleName:middleName
                                      lastName:lastName
                                  emailAddress:emailAddress
                                      username:username
                                      password:password
                                   phoneNumber:phoneNumber
                        inManagedObjectContext:OfficeHoursLocalRepository.sharedRepository.database.managedObjectContext];
}

- (Student *)studentWithUsername:(NSString *)username
{
    return [Student requestStudentWithUsername:username
                        inManagedObjectContext:OfficeHoursLocalRepository.sharedRepository.database.managedObjectContext];
}

- (Student *)studentWithEmailAddress:(NSString *)emailAddress
{
    return [Student requestStudentWithEmailAddress:emailAddress
                            inManagedObjectContext:OfficeHoursLocalRepository.sharedRepository.database.managedObjectContext];
}

- (void)updateStudentWithStudent:(Student *)student
{
    [Student createStudentWithFirstName:student.firstName
                             middleName:student.middleName
                               lastName:student.lastName
                           emailAddress:student.email
                               username:student.username
                               password:student.password
                            phoneNumber:student.phoneNumber
                 inManagedObjectContext:OfficeHoursLocalRepository.sharedRepository.database.managedObjectContext];
}

@end
