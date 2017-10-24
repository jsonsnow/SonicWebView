//
//  SonicSession.h
//  demo_test_textView
//
//  Created by chen liang on 2017/10/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSonicProtocol.h"
#import "CLSonicConstants.h"


/**
 SonicSession use this callback to transfer network data to SonicURLProtocol
 the parameters of the dictionary is:
 @{
     kSonicProtocolAction:@{SonicURLProtocolActionRecvResponse}
     kSonicProtocolData:NSHTTPURLResponse
 }
 */

/** SonicSession use this callback to transfer status data to webview
 @{
 
 code:304,
 srcCode:200,
 result:{},
 local_refresh_time:
 }
 */
typedef void(^SonicURLProtocolCallBack)(NSDictionary *param);


typedef void(^SonicWebviewCallback)(NSDictionary *result);
/**
 SonicSession use this callback to notify SonicClient when it finished

 @param sessionID sessionID
 */
typedef void(^SonicSessionCompleteCallback)(NSString *sessionID);

@interface SonicSession : NSObject<CLSonicSessionProtocol>

/**
 if there is no memory cache and file cache exist
 */
@property (nonatomic, assign) BOOL isFirstLoad;

/**
 url for current session
 */
@property (nonatomic, copy) NSString *url;

/**
 Generated from MD5 of URL.
 */
@property (nonatomic, readonly) NSString *sessionID;

/**
 Generated from local dynamic data and sever dynamic data.
 */
@property (nonatomic, readonly) NSDictionary *diffData;

@property (nonatomic, copy) SonicURLProtocolCallBack protocolCallBack;
@property (nonatomic, weak) id <SonicSessionDelegate> delegate;
@property (nonatomic, copy) SonicSessionCompleteCallback completionCallback;

/**
 check if all data did finish update
 */
@property (nonatomic, assign) BOOL isDataUpdated;

@property (nonatomic, assign) SonicSatusCode sonicSatusCode;

@property (nonatomic, copy) SonicWebviewCallback webviewCallback;
@property (nonatomic, copy) NSString *serverIP;
//register a SonicConnection class to provide network data
+ (BOOL)registerSonicConnection:(Class)connectionClass;
//unregister the SonicConnection
+ (void)unregisterSoinConnection:(Class)connectClass;
//Queue to handle network data
+ (NSOperationQueue *)sonicSessionQueue;

//execute block in sonic session queue return block operation hash string
NSString * dispatchToSonicSessionQueue(dispatch_block_t block);

- (instancetype)initWithUrl:(NSString *)aUlr withWebDelegate:(id<SonicSessionDelegate>)aWebDelegate;
// add custom headers to request
- (void)addCustomRequestHeader:(NSDictionary *)requestHeaders;

//start request
- (void)start;

// cancle reqeust
- (void)cancel;

//it provide the network data by the protocolCallback block
- (void)preloadRequestActionWithProtocolCallback:(SonicURLProtocolCallBack)protocolCallback;

//it provide the session state result by the reusltBlock
- (void)getResultWithCallBack:(SonicWebviewCallback)webviewCallback;

@end
