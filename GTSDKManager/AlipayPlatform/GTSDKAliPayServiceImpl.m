//
//  GTSDKAliPayServiceImpl.m
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import "GTSDKAliPayServiceImpl.h"
#import <AlipaySDK/AlipaySDK.h>

@interface GTSDKAliPayServiceImpl ()

@property (strong, nonatomic) NSString *aliPayScheme;

@end

@implementation GTSDKAliPayServiceImpl

+ (instancetype)sharedService
{
    static GTSDKAliPayServiceImpl *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark -
#pragma mark - 配置部分

- (BOOL)isPlatformAppInstalled
{
    return YES;
}


- (void)registerWithPlatformConfig:(NSDictionary *)config
{
    if (config == nil || config.allKeys.count == 0) return;

    NSString *appScheme = config[GTSDKConfigAppSchemeKey];
    if (appScheme && [appScheme length]) {
        self.aliPayScheme = appScheme;
    }
}

- (BOOL)isRegistered
{
    return (self.aliPayScheme && [self.aliPayScheme length]);
}

- (BOOL)handleResultUrl:(NSURL *)url
{
    return [self payProcessOrderWithPaymentResult:url standbyCallback:NULL];
}


#pragma mark -
#pragma mark -  支付部分

- (void)payOrder:(NSString *)orderString callback:(GTSDKPayCallback)callback
{
    NSLog(@"AliPay");
    [self alipayOrder:orderString callback:callback];
}

- (BOOL)payProcessOrderWithPaymentResult:(NSURL *)url
                         standbyCallback:(void (^)(NSDictionary *))callback
{
    if ([url.scheme.lowercaseString isEqualToString:self.aliPayScheme]) {
        [self aliPayProcessOrderWithPaymentResult:url standbyCallback:callback];
        return YES;
    } else {
        return NO;
    }
}


#pragma mark - alipay
- (void)alipayOrder:(NSString *)orderString callback:(GTSDKPayCallback)callback
{
    [[AlipaySDK defaultService]
     payOrder:orderString
     fromScheme:self.aliPayScheme
     callback:^(NSDictionary *resultDic) {
         NSString *signString = [resultDic objectForKey:@"result"];
         NSString *memo = [resultDic objectForKey:@"memo"];
         NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];
         if (callback) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if (resultStatus == 9000) {
                     callback(signString, nil);
                 } else {
                     NSError *error = [NSError
                                       errorWithDomain:@"AliPay"
                                       code:0
                                       userInfo:[NSDictionary
                                                 dictionaryWithObjectsAndKeys:
                                                 memo, @"NSLocalizedDescription", nil]];
                     callback(signString, error);
                 }

             });
         }
     }];
}

- (void)aliPayProcessOrderWithPaymentResult:(NSURL *)url
                            standbyCallback:(void (^)(NSDictionary *resultDic))callback
{
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:callback];
}

@end
