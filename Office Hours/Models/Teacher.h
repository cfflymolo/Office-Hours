//
//  Teacher.h
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Office, Section, Session;

@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Session *currentSession;
@property (nonatomic, retain) Office *office;
@property (nonatomic, retain) Section *teaches;

@end
