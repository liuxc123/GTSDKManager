//
//  GTSDKShareService.h
//  GTSDKManager_Example
//
//  Created by liuxc on 2018/11/14.
//  Copyright © 2018 liuxc123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GTSDKShareCallback)(BOOL success, NSError *error);

//使用SDK分享，分享内容信息的Key
FOUNDATION_EXTERN NSString *const GTSDKShareContentTitleKey;
FOUNDATION_EXTERN NSString *const GTSDKShareContentDescriptionKey;
FOUNDATION_EXTERN NSString *const GTSDKShareContentImageKey;
FOUNDATION_EXTERN NSString *const GTSDKShareContentWapUrlKey;
FOUNDATION_EXTERN NSString *const GTSDKShareContentTextKey;         //新浪微博分享专用
FOUNDATION_EXTERN NSString *const GTSDKShareContentRedirectURIKey;  //新浪微博分享专用

typedef NS_ENUM(NSUInteger, GTSDKShareToModule) {
    GTSDKShareToContact = 1,  //分享至第三方应用的联系人或组
    GTSDKShareToTimeLine,     //分享至第三方应用的timeLine
    GTSDKShareToOther         //分享至第三方应用的其他模块
};

@protocol GTSDKShareService <NSObject>

/*!
 *  @brief  分享到指定平台
 *
 *  @param content  分享内容
 *  @param shareModule 分享子平台，目前主要包括好友和朋友圈（空间）两部分
 *  @param complete  分享之后的回调
 */
- (void)shareWithContent:(NSDictionary *)content
             shareModule:(NSUInteger)shareModule
              onComplete:(GTSDKShareCallback)complete;

@end
