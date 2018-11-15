# GTSDKManager

对应用中集成的第三方SDK（目前包括QQ,微信,易信,支付宝,钉钉）进行集中管理，按照功能（目前包括第三方登录，分享，支付）开放给产品使用。通过接口的方式进行产品集成。方便对第三方SDK进行升级维护。

## 如何集成GTSDKManager

采用Pod集成：在项目工程的Podfile文件中加载GTSDKManager库：

```
pod 'GTSDKManager' :git => 'https://github.com/liuxc123/GTSDKManager.git'
```

## 如何使用GTSDKManager

通过pod或者代码拷贝manager代码到工程之后，即可通过如下方式调用SDKManager管理的功能：

在应用的appdelegate的didFinishLaunchingWithOptions函数中配置SDK的初始化参数，格式示例：(运行Demo时需要填补对应SDK申请的key和secret，并在工程中配置从sdk应用回调的scheme)

```
 NSArray *regPlatformConfigList = @[
 @{
     GTSDKConfigAppIdKey:@"微信appid",
     GTSDKConfigAppSecretKey:@"微信appsecret",
     GTSDKConfigAppDescriptionKey:@"应用描述",
     GTSDKConfigAppPlatformTypeKey:@(GTSDKPlatformWeChat)
 },
 @{
     GTSDKConfigAppIdKey:@"QQ appid",
     GTSDKConfigAppSecretKey:@"qq appkey",
     GTSDKConfigAppPlatformTypeKey:@(GTSDKPlatformQQ)
 },
 @{
     GTSDKConfigAppSchemeKey:@"支付宝 appScheme",
     GTSDKConfigAppPlatformTypeKey:@(GTSDKPlatformAliPay)
 },
  @{
     GTSDKConfigAppSchemeKey:@"钉钉 appScheme",
     GTSDKConfigAppPlatformTypeKey:@(GTSDKPlatformDingTalk)
 },
  @{
     GTSDKConfigAppIdKey:@"易信appid",
     GTSDKConfigAppSecretKey:@"易信appsecret",
     GTSDKConfigAppPlatformTypeKey:@(GTSDKPlatformYiXin)
 },
 ];
 [GTSDKManager registerWithPlatformConfigList:regPlatformConfigList];
```

获取各项服务的方式：

 

```
/*! 
* @brief 获取配置服务 
*/ 
+ (id)getRegisterService:(GTSDKPlatformType)type;

 /*!
 *  @brief  获取登陆服务
 */
 + (id)getAuthService:(GTSDKPlatformType)type;

 /*!
 *  @brief  获取分享服务
 */
 + (id)getShareService:(GTSDKPlatformType)type;

 /*!
 *  @brief  获取支付服务
 */
 + (id)getPayService:(GTSDKPlatformType)type;
```
2. 配置应用回调时，首先配置info.plist中的URL types，然后在appdelegate中添加代码：

```
 -(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
 {
     return [GTSDKManager handleOpenURL:url];
 }
 
 -(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
     return [GTSDKManager handleOpenURL:url];
 }
```

我们同时提供独立的处理回调方法：

```
 [[GTSDKManager getRegisterService:(GTSDKPlatformType)type] handleResultUrl:(NSURL *)url];

 //对于支付宝，可以针对结果进行进一步的处理
 [[GTSDKManager getPayService:(GTSDKPlatformType)type] payProcessOrderWithPaymentResult:(NSURL *)url standbyCallback:(void (^)(NSDictionary *))callback];
```

3. 需要登陆时，提供对应函数及回调：

```
 /*!
  *  @brief  第三方SDK登录回调
  *
  *  @param oauthInfo 登录口令信息
  *  @param userInfo  第三方用户基本信息
  *  @param error
  */
 typedef void(^GTSDKLoginCallback)(NSDictionary *oauthInfo, NSDictionary *userInfo, NSError *error);

 //判断该平台是否支持登陆
 [[GTSDKManager getAuthService:(GTSDKPlatformType)type] isLoginEnabledOnPlatform]；

 //登陆
 [[GTSDKManager getAuthService:(GTSDKPlatformType)type] loginToPlatformWithCallback:(GTSDKLoginCallback)callback];
```

4. 需要分享时，提供对应函数及回调：


```
 /*!
  *  @brief  第三方SDK分享回调
  *
  *  @param success 是否分享成功
  *  @param error
  */
 typedef void(^GTSDKShareCallback)(BOOL success, NSError *error);

 /*!
 *  @brief  分享到指定平台
 *  @param content  分享内容
 *  @param shareModule 分享子平台，目前主要包括好友和朋友圈（空间）两部分
 *  @param complete  分享之后的回调
 */
 [[GTSDKManager getShareService:(GTSDKPlatformType)type] shareWithContent:(NSDictionary *)content
                                                                 shareModule:(NSUInteger)shareModule
                                                                  onComplete:(GTSDKShareCallback)complete];

 //分享内容字典的key
 FOUNDATION_EXTERN NSString *const GTSDKShareContentTitleKey;
 FOUNDATION_EXTERN NSString *const GTSDKShareContentDescriptionKey;
 FOUNDATION_EXTERN NSString *const GTSDKShareContentImageKey;
 FOUNDATION_EXTERN NSString *const GTSDKShareContentWapUrlKey;
 FOUNDATION_EXTERN NSString *const GTSDKShareContentTextKey;
```

需要支付时，提供对应函数：

```
 /*!
  *  @brief  第三方SDK支付回调
  *
  *  @param signString 签名字符串
  *  @param error
  */
 typedef void(^GTSDKPayCallback)(NSString *signString, NSError *error);

 /**
  *  支付
  *
  *  @param payType     支付类型，支付宝或微信
  *  @param orderString 签名后的订单信息字符串
  *  @param callback    回调
  */
 [[GTSDKManager getPayService:(GTSDKPlatformType)type] payOrder:(NSString *)orderString callback:(GTSDKPayCallback)callback;
```

### GTSDKManager的框架层次

GTSDKManager目前有五个submodule，分别是CoreService，QQService，WechatService，YixinService，AlipayService, DingTalkService。后边四个分别整合了QQSDK、微信SDK、易信SDK以及支付宝SDK，他们都依赖于CoreService。

整合的优点在于： 1. 开发者无需调用SDK头文件，方便SDK的升级； 2. 易拓展，可以通过增加模块使得开发者无需修改代码即可支持更多的第三方SDK。

### 如何新增一个第三方SDK

1. 如果是已有的模块，导入子模块即可；
2. 如果要导入新的SDK，实现步骤：

```
 SDKManager中GTSDKPlatformType添加相应type；
 建立新文件夹，导入SDK文件，编写代码实现[SDKServiceInterface文件夹](GTSDKManager/CoreService/SDKServiceInterface) 中的protocol;
 修改SDKServiceConfig.plist，添加新SDK支持的Service以及对应实现的文件名。GTSDK
```

## 作者

liuxc123, lxc_work@126.com

## 声明

GTSDKManager is available under the MIT license. See the LICENSE file for more info.


