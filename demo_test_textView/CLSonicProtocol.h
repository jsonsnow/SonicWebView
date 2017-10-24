//
//  CLSonicProtocol.h
//  demo_test_textView
//
//  Created by chen liang on 2017/10/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
// brief use this protocal to trasfer data to sonic session,when you provide custom sonicConnection
@class SonicSession;
@protocol CLSonicSessionProtocol <NSObject>
@required

- (void)session:(SonicSession *)session didRecieveResponse:(NSHTTPURLResponse *)response;
- (void)session:(SonicSession *)session didLoadData:(NSData *)data;
- (void)session:(SonicSession *)session didFailed:(NSError *)error;
- (void)sessionDidFinish:(SonicSession *)session;

@end

@protocol SonicSessionDelegate <NSObject>
@required
- (void)session:(SonicSession *)session requireWebViewReload:(NSURLRequest *)request;
@optional
- (void)sessionWillRequest:(SonicSession *)session;

@end
