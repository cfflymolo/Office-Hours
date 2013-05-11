//
//  LocalRepositoryAssistant.h
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface LocalRepositoryAssistant : NSObject

+ (NSManagedObject *)createManagedObjectForClass:(Class)class withParameters:(NSDictionary *)parameters inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSArray *)performDatabaseFetchRequestForClass:(Class)class withParameters:(NSDictionary *)parameters inManagedObjectContext:(NSManagedObjectContext *)context;

+ (NSFetchedResultsController *)generateFetchedResultsControllerForClass:(Class)class withParameters:(NSDictionary *)paramters andSortDescriptorKey:(NSString *)sortDescriptorKey inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)saveChangesToContext:(NSManagedObjectContext *)context;

@end
