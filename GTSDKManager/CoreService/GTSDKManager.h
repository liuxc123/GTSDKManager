//
//  GTSDKManager.h
//  GTSDKManager_Example
//
//  Created by liuxc on 2018/11/14.
//  Copyright © 2018 liuxc123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, GTSDKPlatformType) {
    GTSDKPlatformQQ = 1,  // QQ
    GTSDKPlatformWeChat,  //微信
    GTSDKPlatformAliPay,  //支付宝
    GTSDKPlatformWeibo,   //新浪微博
    GTSDKPlatformYiXin,   //易信
};

@interface GTSDKManager : NSObject

/**
 *  根据配置列表依次注册第三方SDK
 *
 *  @return YES则配置成功
 */
+ (void)registerWithPlatformConfigList:(NSArray *)configList;

/*!
 *  @brief  统一处理各个SDK的回调
 *
 *  @param url 回调URL
 *
 *  @return 处理成功返回YES，否则返回NO
 */
+ (BOOL)handleOpenURL:(NSURL *)url;

/*!
 *  @brief  获取配置服务
 *
 *  @return 服务实例
 */
+ (id)getRegisterService:(GTSDKPlatformType)type;

/*!
 *  @brief  获取登陆服务
 *
 *  @return 服务实例
 */
+ (id)getAuthService:(GTSDKPlatformType)type;

/*!
 *  @brief  获取分享服务
 *
 *  @return 服务实例
 */
+ (id)getShareService:(GTSDKPlatformType)type;

/*!
 *  @brief  获取支付服务
 *
 *  @return 服务实例
 */
+ (id)getPayService:(GTSDKPlatformType)type;

@end
