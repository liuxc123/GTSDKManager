//
//  GTSDKDingTalkServiceImpl.m
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import "GTSDKDingTalkServiceImpl.h"
#import <DTShareKit/DTOpenKit.h>
#import "UIImage+GTSDKShare.h"

@interface GTSDKDingTalkServiceImpl() <DTOpenAPIDelegate>

@property (nonatomic, copy) NSString *dtAppid;
@property (nonatomic, copy) NSString *dtAppSecret;
@property (nonatomic, copy) GTSDKDTCallbackBlock callbackBlock;

@end

@implementation GTSDKDingTalkServiceImpl

+ (instancetype)sharedService
{
    static GTSDKDingTalkServiceImpl *sharedInstance = nil;
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
    return [DTOpenAPI isDingTalkInstalled] && [DTOpenAPI isDingTalkSupportOpenAPI];
}

- (void)registerWithPlatformConfig:(NSDictionary *)config
{
    if (config == nil || config.allKeys.count == 0) return;
    NSString *dtAppId = config[GTSDKConfigAppIdKey];
    //    NSString *yxAppSecret = config[GTSDKRegisterAppSecretKey];
    if (dtAppId && [dtAppId length]) {
        [DTOpenAPI registerApp:dtAppId];
        self.dtAppid = dtAppId;
    }
}

- (BOOL)isRegistered
{
    return (self.dtAppid && [self.dtAppid length]);
}

#pragma mark -
#pragma mark - 处理URL回调

- (BOOL)handleResultUrl:(NSURL *)url
{
    return [self handleOpenURL: url];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    return [DTOpenAPI handleOpenURL:url delegate:self];
}

#pragma mark -
#pragma mark - 分享部分

- (void)shareWithContent:(NSDictionary *)content
             shareModule:(NSUInteger)shareModule
              onComplete:(GTSDKShareCallback)complete
{
    if (![DTOpenAPI isDingTalkInstalled] || ![DTOpenAPI isDingTalkSupportOpenAPI]) {

        NSError *error = [NSError
                          errorWithDomain:@"DTShare"
                          code:0
                          userInfo:[NSDictionary
                                    dictionaryWithObjectsAndKeys:@"请先安装钉钉客户端",
                                    @"NSLocalizedDescription", nil]];
        if (complete) {
            complete(NO, error);
        }
        return;
    }

    NSString *title = content[@"title"];
    NSString *description = content[@"description"];
    NSString *urlString = content[@"webpageurl"];
    UIImage *oldImage = content[@"image"];

    DTMediaMessage *message = [[DTMediaMessage alloc] init];
    message.title = title;
    message.messageDescription = description;

    if (urlString) {  //分享链接
        if (oldImage) {
            //控件大小，否则无法跳转
            UIImage *image = oldImage;
            CGSize thumbSize = image.size;
            UIImage *thumbImage = image;
            if (image.scale > 1.0) {
                thumbImage = [image GTSDKShare_resizedImage:image.size
                                       interpolationQuality:kCGInterpolationDefault];
            }

            NSData *thumbData = UIImageJPEGRepresentation(thumbImage, 0.0);
            while (thumbData.length > 64 * 1024) {  //不能超过64K
                thumbSize = CGSizeMake(thumbSize.width / 2.0, thumbSize.height / 2.0);
                thumbImage = [thumbImage GTSDKShare_resizedImage:thumbSize
                                            interpolationQuality:kCGInterpolationDefault];
                thumbData = UIImageJPEGRepresentation(thumbImage, 0.0);
            }
            [message setThumbData:thumbData];
        }


        DTMediaWebObject *ext = [[DTMediaWebObject alloc] init];
        ext.pageURL = urlString;
        message.mediaObject = ext;
    } else if (oldImage) {  //分享图片
        UIImage *image = oldImage;
        DTMediaImageObject *ext = [[DTMediaImageObject alloc] init];
        ext.imageData = UIImageJPEGRepresentation(image, 1.0);
        message.mediaObject = ext;

        CGSize thumbSize = image.size;
        UIImage *thumbImage = image;
        if (image.scale > 1.0) {
            thumbImage = [image GTSDKShare_resizedImage:image.size
                                   interpolationQuality:kCGInterpolationDefault];
        }

        NSData *thumbData = UIImageJPEGRepresentation(thumbImage, 0.0);
        while (thumbData.length > 64 * 1024) {  //不能超过64K
            thumbSize = CGSizeMake(thumbSize.width / 2.0, thumbSize.height / 2.0);
            thumbImage = [thumbImage GTSDKShare_resizedImage:thumbSize
                                        interpolationQuality:kCGInterpolationDefault];
            thumbData = UIImageJPEGRepresentation(thumbImage, 0.0);
        }
        [message setThumbData:thumbData];
    } else {
        NSAssert(0, @"YiXin ContentItem Error");
    }

    DTSendMessageToDingTalkReq *req = [[DTSendMessageToDingTalkReq alloc] init];
    req.message = message;

    
    if (shareModule == 1) {
        req.scene = DTSceneSession;
    }

    [self sendReq:req callback:^(DTBaseResp *resp) {
         [self handleShareResultInActivity:resp onComplete:complete];
    }];
}

- (void)handleShareResultInActivity:(id)result onComplete:(void (^)(BOOL, NSError *))complete
{

    DTSendMessageToDingTalkResp *response = (DTSendMessageToDingTalkResp *)result;

    switch (response.errorCode) {
        case DTOpenAPISuccess:
            if (complete) {
                complete(YES, nil);
            }

            break;
        case DTOpenAPIErrorCodeUserCancel: {
            NSError *error = [NSError
                              errorWithDomain:@"DTShare"
                              code:-2
                              userInfo:[NSDictionary
                                        dictionaryWithObjectsAndKeys:@"用户取消分享",
                                        @"NSLocalizedDescription", nil]];
            if (complete) {
                complete(NO, error);
            }
        } break;
        default: {
            NSError *error = [NSError
                              errorWithDomain:@"DTShare"
                              code:-1
                              userInfo:[NSDictionary
                                        dictionaryWithObjectsAndKeys:@"分享失败",
                                        @"NSLocalizedDescription", nil]];
            if (complete) {
                complete(NO, error);
            }
        }

            break;
    }
}
- (BOOL)sendReq:(DTBaseReq *)req callback:(GTSDKDTCallbackBlock)callbackBlock
{
    self.callbackBlock = callbackBlock;
    return [DTOpenAPI sendReq:req];
}

#pragma mark DTOpenAPIDelegate

- (void)onReq:(DTBaseReq *)req
{
#ifdef DEBUG
    NSLog(@"[%@]%s", NSStringFromClass([self class]), __FUNCTION__);
#endif
}

- (void)onResp:(DTBaseResp *)resp
{
#ifdef DEBUG
    NSLog(@"[%@]%s", NSStringFromClass([self class]), __FUNCTION__);
#endif

    if (self.callbackBlock) {
        self.callbackBlock(resp);
    }
}

@end
