//
//  CLCustomProtocol.m
//  demo_test_textView
//
//  Created by chen liang on 2017/10/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "CLCustomProtocol.h"
#define SonicHeaderKeyLoadType @"sonic-load-type"
#define SonicHeaderValueSonicLoad @"sonic-header-value-sonic-load"
#define sonicHeaderValueWebviewload @"sonic-header-value-webview-load"
#define SonicHeaderKeySessionID @"sonic-sessionId"

@implementation CLCustomProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    NSString *value = [request.allHTTPHeaderFields objectForKey:SonicHeaderKeyLoadType];
    if (value.length == 0) {
        return NO;
    }
    if ([value isEqualToString:SonicHeaderValueSonicLoad]) {
        return NO;
    }
    if ([value isEqualToString:sonicHeaderValueWebviewload]) {
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

- (void)startLoading {
    
    NSThread *currentThread = [NSThread currentThread];
    NSString *sessionID = [self.request valueForHTTPHeaderField:SonicHeaderKeySessionID];
}
- (void)stopLoading {
    
    
}
@end
