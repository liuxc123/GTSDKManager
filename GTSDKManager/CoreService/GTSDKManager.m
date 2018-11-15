//
//  GTSDKManager.m
//  GTSDKManager_Example
//
//  Created by liuxc on 2018/11/14.
//  Copyright © 2018 liuxc123. All rights reserved.
//

#import "GTSDKManager.h"
#import "GTSDKRegisterService.h"
#import "GTSDKPayService.h"
#import "GTSDKAuthService.h"
#import "GTSDKShareService.h"

NSString *const GTSDKConfigAppIdKey = @"kAppID";
NSString *const GTSDKConfigAppSecretKey = @"kAppSecret";
NSString *const GTSDKConfigAppSchemeKey = @"kAppScheme";
NSString *const GTSDKConfigAppPlatformTypeKey = @"kAppPlatformType";
NSString *const GTSDKConfigAppDescriptionKey = @"kAppDescription";

NSString *const GTSDKShareContentTitleKey = @"title";
NSString *const GTSDKShareContentDescriptionKey = @"description";
NSString *const GTSDKShareContentImageKey = @"image";
NSString *const GTSDKShareContentWapUrlKey = @"webpageurl";
NSString *const GTSDKShareContentTextKey = @"text";
NSString *const GTSDKShareContentRedirectURIKey = @"redirectURI";

static NSArray *sdkServiceConfigList = nil;
@implementation GTSDKManager

/**
 *  根据配置列表依次注册第三方SDK
 *
 *  @return YES则配置成功
 */
+ (void)registerWithPlatformConfigList:(NSArray *)configList;
{
    if (configList == nil || configList.count == 0) return;

    for (NSDictionary *onePlatformConfig in configList) {
        GTSDKPlatformType platformType =
        [onePlatformConfig[GTSDKConfigAppPlatformTypeKey] intValue];
        Class registerServiceImplCls =
        [[self class] getServiceProviderWithPlatformType:platformType];
        if (registerServiceImplCls != nil) {
            [[registerServiceImplCls sharedService] registerWithPlatformConfig:onePlatformConfig];
        }
    }
}

/**
 *  处理应用回调URL
 *
 *  @return YES
 */
+ (BOOL)handleOpenURL:(NSURL *)url
{
    if (sdkServiceConfigList == nil) {
        NSString *plistPath =
        [[NSBundle mainBundle] pathForResource:@"SDKServiceConfig" ofType:@"plist"];
        sdkServiceConfigList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }

    for (NSDictionary *oneSDKServiceConfig in sdkServiceConfigList) {
        Class serviceProvider = NSClassFromString(oneSDKServiceConfig[@"serviceProvider"]);
        if (serviceProvider) {
            if ([[serviceProvider sharedService]
                 conformsToProtocol:@protocol(GTSDKRegisterService)]) {
                if ([[serviceProvider sharedService] handleResultUrl:url]) {
                    return YES;
                }
            }
        }
    }

    return NO;
}

+ (id)getRegisterService:(GTSDKPlatformType)type
{
    Class shareServiceImplCls = [self getServiceProviderWithPlatformType:type];
    if (shareServiceImplCls) {
        if ([[shareServiceImplCls sharedService]
             conformsToProtocol:@protocol(GTSDKRegisterService)]) {
            return [shareServiceImplCls sharedService];
        }
    }
    return nil;
}

+ (id)getAuthService:(GTSDKPlatformType)type
{
    Class shareServiceImplCls = [self getServiceProviderWithPlatformType:type];
    if (shareServiceImplCls) {
        if ([[shareServiceImplCls sharedService] conformsToProtocol:@protocol(GTSDKAuthService)]) {
            return [shareServiceImplCls sharedService];
        }
    }
    return nil;
}

+ (id)getShareService:(GTSDKPlatformType)type
{
    Class shareServiceImplCls = [self getServiceProviderWithPlatformType:type];
    if (shareServiceImplCls) {
        if ([[shareServiceImplCls sharedService] conformsToProtocol:@protocol(GTSDKShareService)]) {
            return [shareServiceImplCls sharedService];
        }
    }
    return nil;
}

+ (id)getPayService:(GTSDKPlatformType)type
{
    Class shareServiceImplCls = [self getServiceProviderWithPlatformType:type];
    if (shareServiceImplCls) {
        if ([[shareServiceImplCls sharedService] conformsToProtocol:@protocol(GTSDKPayService)]) {
            return [shareServiceImplCls sharedService];
        }
    }
    return nil;
}

/**
 * 根据平台类型和服务类型获取服务提供者
 */
+ (Class)getServiceProviderWithPlatformType:(GTSDKPlatformType)platformType
{
    if (sdkServiceConfigList == nil) {
        NSString *plistPath =
        [[NSBundle mainBundle] pathForResource:@"SDKServiceConfig" ofType:@"plist"];
        sdkServiceConfigList = [[NSArray alloc] initWithContentsOfFile:plistPath];
    }

    Class serviceProvider = nil;
    for (NSDictionary *oneSDKServiceConfig in sdkServiceConfigList) {
        // find the specified platform
        if ([oneSDKServiceConfig[@"platformType"] intValue] == platformType) {
            serviceProvider = NSClassFromString(oneSDKServiceConfig[@"serviceProvider"]);
            break;
        }  // if
    }

    return serviceProvider;
}

@end
