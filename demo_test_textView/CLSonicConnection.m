//
//  CLSonicConnection.m
//  demo_test_textView
//
//  Created by chen liang on 2017/10/12.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import "CLSonicConnection.h"

@interface CLSonicConnection ()<NSURLSessionTaskDelegate,NSURLSessionDataDelegate>
@property (nonatomic, retain) NSURLSession *dataSession;
@property (nonatomic, retain) NSURLSessionDataTask *dataTask;

@end
@implementation CLSonicConnection

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    return YES;
}

- (instancetype)initWithRequest:(NSURLRequest *)request {
    
    if (self = [super init]) {
        
        _request  = request;
    }
    return self;
}

- (void)startLoading {
    
    NSURLSessionConfiguration *sessionCfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionCfg.requestCachePolicy = NSURLRequestReloadIgnoringCacheData;
    self.dataSession = [NSURLSession sessionWithConfiguration:sessionCfg delegate:self delegateQueue:nil];
    self.dataTask = [self.dataSession dataTaskWithRequest:_request];
    [self.dataTask resume];
}

- (void)stopLoading {
    if (self.dataTask && self.dataTask.state == NSURLSessionTaskStateRunning) {
        [self.dataTask cancel];
        [self.dataSession finishTasksAndInvalidate];
    } else
        [self.dataSession invalidateAndCancel];
}

- (BOOL)validateSessionState {
    
    return [self.session conformsToProtocol:@protocol(CLSonicSessionProtocol)] && self.session;
}
#pragma mark -- NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (![self validateSessionState]) {
        return;
    }
    if (error) {
        
        [self.session session:self.session didFailed:error];
    } else
        [self.session sessionDidFinish:self.session];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    SecTrustResultType resutl;
    NSString *host = [[task currentRequest] valueForHTTPHeaderField:@"host"];
    SecPolicyRef policyOverride = SecPolicyCreateSSL(true, (CFStringRef)host);
    NSMutableArray *policies = [NSMutableArray array];
    [policies addObject:(__bridge id)policyOverride];
    SecTrustSetPolicies(trust, (__bridge CFArrayRef)policies);
    OSStatus status = SecTrustEvaluate(trust, &resutl);
    if (status == errSecSuccess && (resutl == kSecTrustResultProceed || resutl == kSecTrustResultUnspecified)) {
        
        NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
    if (![self validateSessionState]) {
        return;
    }
    [self.session session:self.session didRecieveResponse:(NSHTTPURLResponse *)response];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task willPerformHTTPRedirection:(NSHTTPURLResponse *)response newRequest:(NSURLRequest *)request completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    
    completionHandler(nil);
    if (![self validateSessionState]) {
        return;
    }
    
    NSError *redirectErr = [NSError errorWithDomain:@"com.sonic.connect" code:302 userInfo:@{@"msg":@"sonic can't make 302 jumo"}];
    [self.session session:self.session didFailed:redirectErr];
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
    if (![self validateSessionState]) {
        return;
    }
    [self.session session:self.session didLoadData:data];
}

- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    
    if (![self validateSessionState]) {
        return;
    }
    if (error) {
        [self.session session:self.session didFailed:error];
    }
}
@end
