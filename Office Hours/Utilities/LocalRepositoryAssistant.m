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

+ (NSDate *)dateFromDotNetJSONString:(NSString *)string
{
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$"
                                                         options:NSRegularExpressionCaseInsensitive
                                                           error:nil];
    });
    
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string
                                                              options:0
                                                                range:NSMakeRange(0, string.length)];
    
    if (regexResult) {
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    
    return nil;
}

+ (NSString *)dotNetJSONStringFromDate:(NSDate *)date
{
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    offset /= 3600;
    double nowMilliseconds = 1000.0 * [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"/Date(%.0f%+03d00)/", nowMilliseconds, offset];
}

+ (NSManagedObject *)createManagedObjectForClass:(Class)class
                                  withParameters:(NSDictionary *)parameters
                          inManagedObjectContext:(NSManagedObjectContext *)context
{
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(class)
                                                            inManagedObjectContext:context];
    NSDictionary *attributes = [object.entity propertiesByName];
    
    for (NSString *attribute in attributes) {
        id value = parameters[attribute];
        if (!value || [value isEqual:[NSNull null]]) {
            continue;
        }
        
        NSAttributeType attributeType = [[attributes objectForKey:attribute] attributeType];
        
        if ((attributeType == NSStringAttributeType) && ([value isKindOfClass:[NSNumber class]])) {
            value = [value stringValue];
        } else if (((attributeType == NSInteger16AttributeType) ||
                    (attributeType == NSInteger32AttributeType) ||
                    (attributeType == NSInteger64AttributeType) ||
                    (attributeType == NSBooleanAttributeType)) &&
                   ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithInteger:[value integerValue]];
        } else if ((attributeType == NSFloatAttributeType) && ([value isKindOfClass:[NSString class]])) {
            value = [NSNumber numberWithDouble:[value doubleValue]];
        } else if (attributeType == NSDateAttributeType) {
            NSString *dateString = [NSString stringWithFormat:@"%@", value];
            
            if ([dateString rangeOfString:@"Date"].location != NSNotFound) {
                
            }
        }
        
        [object setValue:value forKey:attribute];
    }

    return object;
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
