//
//  GTSDKYXServiceImpl.h
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import <Foundation/Foundation.h>
#import "GTSDKRegisterService.h"
#import "GTSDKShareService.h"

@class YXBaseReq;
@class YXBaseResp;

typedef void (^GTSDKYXCallbackBlock)(YXBaseResp *resp);

@interface GTSDKYXServiceImpl : NSObject <GTSDKRegisterService, GTSDKShareService>

@end
