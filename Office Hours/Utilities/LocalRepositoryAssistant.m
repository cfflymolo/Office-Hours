//
//  LocalRepositoryAssistant.m
//  Office Hours
//
//  Created by Robert Colin on 5/9/13.
//
//

#import "LocalRepositoryAssistant.h"

@implementation LocalRepositoryAssistant

+ (NSFetchRequest *)generateFetchRequestForClass:(Class)class withParameters:(NSDictionary *)parameters
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass(class)];
    
    if (parameters) {
        NSMutableArray *parts = [[NSMutableArray alloc] initWithCapacity:parameters.allKeys.count];
        
        for (id key in parameters) {
            id value = [parameters objectForKey:key];
            if ([value isKindOfClass:[NSString class]]) {
                [parts addObject:[NSString stringWithFormat:@"%@ = \"%@\"", key, value]];
            } else {
                [parts addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
            }
        }
        
        NSString *args = [parts componentsJoinedByString:@" && "];
        request.predicate = [NSPredicate predicateWithFormat:args];
    }
    
    return request;
}

+ (NSArray *)performDatabaseFetchRequestForClass:(Class)class
                                  withParameters:(NSDictionary *)parameters
                          inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSError *error = nil;
    return [context executeFetchRequest:[self generateFetchRequestForClass:class
                                                            withParameters:parameters]
                                  error:&error];
}

+ (NSFetchedResultsController *)generateFetchedResultsControllerForClass:(Class)class
                                                          withParameters:(NSDictionary *)paramters
                                                    andSortDescriptorKey:(NSString *)sortDescriptorKey
                                                  inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSFetchRequest *request = [self generateFetchRequestForClass:class withParameters:paramters];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:sortDescriptorKey ascending:YES]];
    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                               managedObjectContext:context
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];
}

+ (void)saveChangesToContext:(NSManagedObjectContext *)context
{
    if ([context hasChanges]) {
        NSError *error;
        if ([context save:&error]) {
            NSLog(@"Sucessfully saved objects in context");
        } else {
            NSLog(@"savedChangesToContextError: %@", error.localizedDescription);
        }
    }
}

@end
