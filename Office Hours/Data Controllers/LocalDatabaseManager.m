//
//  LocalDatabaseManager.m
//  Office Hours
//
//  Created by Robert Colin on 5/7/13.
//
//

#import "LocalDatabaseManager.h"

@implementation LocalDatabaseManager

+ (LocalDatabaseManager *)sharedDatabaseManager
{
    static LocalDatabaseManager *_sharedDatabaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDatabaseManager = [LocalDatabaseManager new];
    });
    return _sharedDatabaseManager;
}



@end
