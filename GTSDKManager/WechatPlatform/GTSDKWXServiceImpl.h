//
//  GTSDKWXServiceImpl.h
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import <Foundation/Foundation.h>
#import "GTSDKAuthService.h"
#import "GTSDKRegisterService.h"
#import "GTSDKPayService.h"
#import "GTSDKShareService.h"

@class BaseReq;
@class BaseResp;

typedef void (^GTSDKWXCallbackBlock)(BaseResp *resp);

@interface GTSDKWXServiceImpl : NSObject <GTSDKAuthService, GTSDKRegisterService, GTSDKShareService, GTSDKPayService>

@end
