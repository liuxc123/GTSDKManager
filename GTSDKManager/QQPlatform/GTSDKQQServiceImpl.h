//
//  GTSDKQQServiceImpl.h
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import <Foundation/Foundation.h>
#import "GTSDKAuthService.h"
#import "GTSDKRegisterService.h"
#import "GTSDKShareService.h"

@class QQBaseReq;
@class QQBaseResp;

typedef void (^GTSDKQQCallbackBlock)(QQBaseResp *resp);

@interface GTSDKQQServiceImpl : NSObject <GTSDKAuthService, GTSDKRegisterService, GTSDKShareService>

@end
