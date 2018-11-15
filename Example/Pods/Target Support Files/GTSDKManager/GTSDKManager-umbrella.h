#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "GTSDKAliPayServiceImpl.h"
#import "AlipaySDK.h"
#import "APayAuthInfo.h"
#import "GTSDKManager.h"
#import "GTSDKAuthService.h"
#import "GTSDKPayService.h"
#import "GTSDKRegisterService.h"
#import "GTSDKShareService.h"
#import "DTOpenAPI.h"
#import "DTOpenAPIObject.h"
#import "DTOpenKit.h"
#import "GTSDKDingTalkServiceImpl.h"
#import "GTSDKQQServiceImpl.h"
#import "QQApi.h"
#import "QQApiInterface.h"
#import "QQApiInterfaceObject.h"
#import "sdkdef.h"
#import "TencentApiInterface.h"
#import "TencentMessageObject.h"
#import "TencentOAuth.h"
#import "TencentOAuthObject.h"
#import "WeiBoAPI.h"
#import "WeiyunAPI.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "WBHttpRequest+WeiboGame.h"
#import "WBHttpRequest+WeiboShare.h"
#import "WBHttpRequest+WeiboToken.h"
#import "WBHttpRequest+WeiboUser.h"
#import "WBHttpRequest.h"
#import "WBSDKBasicButton.h"
#import "WBSDKCommentButton.h"
#import "WBSDKRelationshipButton.h"
#import "WeiboSDK.h"
#import "WeiboUser.h"
#import "YXApi.h"
#import "YXApiObject.h"

FOUNDATION_EXPORT double GTSDKManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char GTSDKManagerVersionString[];

