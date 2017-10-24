//
//  CLSonicConstants.h
//  demo_test_textView
//
//  Created by chen liang on 2017/10/13.
//  Copyright © 2017年 chen liang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SonicDefaultUserAgent @"Mozilla/5.0 (iPhone;U;CPU iPhone OS 2_2 like Mac OS X;\
en-us) AppleWebKit/525.181(KHTML,like Gecko) Version/3.1.1 Moblie/5H11 Safari/525.20"

// Sonic status code
typedef NS_ENUM(NSUInteger,SonicSatusCode) {
    
    //No dynamic data will be update.
    SonicSatusCodeAllCached = 304,
    // the template need to update
    SonicSatusCodeTemplateUpate = 2000,
    // there is no local cache ,need to request all data from server
    SonicSatusCodeFirstLoad = 1000,
    //Only need to request dynaimc data.
    SonicSatusCodeUpdate = 200,
};
// NSURLProtocol client action
typedef NS_ENUM(NSUInteger,SonicURLProtocolAction) {
    
    SonicURLProtocolActionLoadData,
    SonicURLProtocolActionRecvResponse,
    SonicURLProtocolActionDidFinsh,
    SoinicURLProtocolActionDidFaild
};
