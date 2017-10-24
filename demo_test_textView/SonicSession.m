//
//  SonicSession.m
//  demo_test_textView
//
//  Created by chen liang on 2017/10/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "SonicSession.h"
#import <objc/runtime.h>
#import "CLSonicConnection.h"

static NSMutableArray *sonicRequestClassArray = nil;
static NSLock *sonicRequestClassLock;
@interface SonicSession ()
@property (nonatomic, retain) NSData *cacheFileData;
@property (nonatomic, retain) NSDictionary *cacheConfigHeaders;
@property (nonatomic, retain) NSDictionary *cacheResponseHeaders;
@property (nonatomic, strong) NSHTTPURLResponse *response;
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) BOOL isCompletion;
@property (nonatomic, assign) SonicSatusCode sonicSatusFinalCode;
@property (nonatomic, copy) NSString *localRefreshTime;
@property (nonatomic, retain) CLSonicConnection *mCustomConnection;
@property (nonatomic, strong) NSMutableURLRequest *request;
@property (nonatomic, assign) BOOL disFinshCacheRead;


/**
 Use to hold all block operation in sonic session queue
 We need to cancel before the SonicSession dealloc
 */
@property (nonatomic, strong) NSMutableArray *sonicQueueOperationIndetifiers;


/**
 Use to hold all block operation in main queue
 We need to cancle before the SonicSession dealloc
 */
@property (nonatomic, strong) NSMutableArray *mainQueueOperationIndentiFiers;

@end
@implementation SonicSession
+ (BOOL)registerSonicConnection:(Class)connectionClass {
    
    if (![connectionClass isSubclassOfClass:[CLSonicConnection class]]) {
        return NO;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sonicRequestClassArray) {
            sonicRequestClassArray = @[].mutableCopy;
            sonicRequestClassLock = [NSLock new];
        }
    });
    [sonicRequestClassLock lock];
    [sonicRequestClassArray removeAllObjects];
    [sonicRequestClassArray addObject:connectionClass];
    [sonicRequestClassLock unlock];
    return YES;
}

+ (void)unregisterSoinConnection:(Class)connectClass {
    
    [sonicRequestClassLock lock];
    if (![sonicRequestClassArray containsObject:connectClass]) {
        [sonicRequestClassArray removeObject:connectClass];
    }
    [sonicRequestClassLock unlock];
}
+ (Class)lastCanUseRequestClass {
    
    Class rClass = nil;
    [sonicRequestClassLock lock];
    rClass = [sonicRequestClassArray lastObject];
    [sonicRequestClassLock unlock];
    return rClass;
}
+ (NSOperationQueue *)sonicSessionQueue {
    
    static NSOperationQueue *_sonicSessionQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sonicSessionQueue = [[NSOperationQueue alloc] init];
        _sonicSessionQueue.name = @"SonicSessionQueue";
        _sonicSessionQueue.qualityOfService = NSQualityOfServiceUserInitiated;
    });
    return _sonicSessionQueue;
}
@end
