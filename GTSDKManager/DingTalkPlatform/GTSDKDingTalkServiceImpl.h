//
//  GTSDKDingTalkServiceImpl.h
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import <Foundation/Foundation.h>
#import "GTSDKRegisterService.h"
#import "GTSDKShareService.h"

@class DTBaseReq;
@class DTBaseResp;

typedef void (^GTSDKDTCallbackBlock)(DTBaseResp *resp);

@interface GTSDKDingTalkServiceImpl : NSObject <GTSDKRegisterService, GTSDKShareService>

@end
