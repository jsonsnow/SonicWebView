//
//  CLSonicConnection.h
//  demo_test_textView
//
//  Created by chen liang on 2017/10/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLSonicProtocol.h"

@interface CLSonicConnection : NSObject
@property (nonatomic, weak) id <CLSonicSessionProtocol> session;
@property (nonatomic, readonly) NSURLRequest *request;

+ (BOOL)canInitWithRequest:(NSURLRequest *)request;

- (instancetype)initWithRequest:(NSURLRequest *)request;

- (void)startLoading;
- (void)stopLoading;

@end
