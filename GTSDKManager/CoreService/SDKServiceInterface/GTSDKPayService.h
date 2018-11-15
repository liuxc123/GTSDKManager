//
//  GTSDKPayService.h
//  GTSDKManager_Example
//
//  Created by liuxc on 2018/11/14.
//  Copyright © 2018 liuxc123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GTSDKPayCallback)(NSString *signString, NSError *error);

@protocol GTSDKPayService <NSObject>

/**
 *  请求支付
 *
 *  @param orderString 支付的订单串
 *  @param callback    回调方法
 */
- (void)payOrder:(NSString *)orderString callback:(GTSDKPayCallback)callback;

/**
 *  回调处理
 *
 *  @param url      回调的url
 *  @param callback 处理的回调方法
 */
- (BOOL)payProcessOrderWithPaymentResult:(NSURL *)url
                         standbyCallback:(void (^)(NSDictionary *resultDic))callback;

@end
