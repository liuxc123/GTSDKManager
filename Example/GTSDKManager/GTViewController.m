//
//  GTViewController.m
//  GTSDKManager
//
//  Created by liuxc123 on 11/14/2018.
//  Copyright (c) 2018 liuxc123. All rights reserved.
//

#import "GTViewController.h"
#import "GTSDKManager.h"

#import "GTSDKRegisterService.h"
#import "GTSDKPayService.h"
#import "GTSDKAuthService.h"
#import "GTSDKShareService.h"

@interface GTViewController () {
    UILabel *infoLabel;
}

@end

@implementation GTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    UIButton *loginWXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginWXBtn setFrame:CGRectMake(25, 75, 120, 40)];
    [loginWXBtn.layer setBorderWidth:1.0];
    [loginWXBtn setTitle:@"微信登陆" forState:UIControlStateNormal];
    [loginWXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginWXBtn addTarget:self
                   action:@selector(loginByWX)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginWXBtn];

    UIButton *loginQQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginQQBtn setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 145, 75, 120, 40)];
    [loginQQBtn.layer setBorderWidth:1.0];
    [loginQQBtn setTitle:@"QQ登陆" forState:UIControlStateNormal];
    [loginQQBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginQQBtn addTarget:self
                   action:@selector(loginByQQ)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginQQBtn];

    UIButton *shareQQBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareQQBtn setFrame:CGRectMake(25, 140, 120, 40)];
    [shareQQBtn.layer setBorderWidth:1.0];
    [shareQQBtn setTitle:@"QQ分享" forState:UIControlStateNormal];
    [shareQQBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareQQBtn addTarget:self
                   action:@selector(shareByQQ)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareQQBtn];

    UIButton *shareQzoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareQzoneBtn
     setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 145, 140, 120, 40)];
    [shareQzoneBtn.layer setBorderWidth:1.0];
    [shareQzoneBtn setTitle:@"QQ空间分享" forState:UIControlStateNormal];
    [shareQzoneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareQzoneBtn addTarget:self
                      action:@selector(shareByQzone)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareQzoneBtn];

    UIButton *shareWXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareWXBtn setFrame:CGRectMake(25, 190, 120, 40)];
    [shareWXBtn.layer setBorderWidth:1.0];
    [shareWXBtn setTitle:@"微信分享" forState:UIControlStateNormal];
    [shareWXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareWXBtn addTarget:self
                   action:@selector(shareByWX)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareWXBtn];

    UIButton *shareWXTimelineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareWXTimelineBtn
     setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 145, 190, 120, 40)];
    [shareWXTimelineBtn.layer setBorderWidth:1.0];
    [shareWXTimelineBtn setTitle:@"朋友圈分享" forState:UIControlStateNormal];
    [shareWXTimelineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareWXTimelineBtn addTarget:self
                           action:@selector(shareByWXTimeline)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareWXTimelineBtn];

    UIButton *shareYXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareYXBtn setFrame:CGRectMake(25, 240, 120, 40)];
    [shareYXBtn.layer setBorderWidth:1.0];
    [shareYXBtn setTitle:@"易信分享" forState:UIControlStateNormal];
    [shareYXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareYXBtn addTarget:self
                   action:@selector(shareByYX)
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareYXBtn];

    UIButton *shareYXTimelineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareYXTimelineBtn
     setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 145, 240, 120, 40)];
    [shareYXTimelineBtn.layer setBorderWidth:1.0];
    [shareYXTimelineBtn setTitle:@"朋友圈分享" forState:UIControlStateNormal];
    [shareYXTimelineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareYXTimelineBtn addTarget:self
                           action:@selector(shareByYXTimeline)
                 forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareYXTimelineBtn];

    UIButton *shareWeiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareWeiboBtn setFrame:CGRectMake(25, 310, 120, 40)];
    [shareWeiboBtn.layer setBorderWidth:1.0];
    [shareWeiboBtn setTitle:@"微博分享" forState:UIControlStateNormal];
    [shareWeiboBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareWeiboBtn addTarget:self
                      action:@selector(shareByWeibo)
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareWeiboBtn];

    UIButton *payWXBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payWXBtn setFrame:CGRectMake(25, 380, 120, 40)];
    [payWXBtn.layer setBorderWidth:1.0];
    [payWXBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [payWXBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payWXBtn addTarget:self
                 action:@selector(payByWX)
       forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payWXBtn];

    UIButton *payAliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [payAliBtn setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 145, 380, 120, 40)];
    [payAliBtn.layer setBorderWidth:1.0];
    [payAliBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [payAliBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [payAliBtn addTarget:self
                  action:@selector(payByAli)
        forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payAliBtn];

    infoLabel = [[UILabel alloc]
                 initWithFrame:CGRectMake(25, 450, [UIScreen mainScreen].bounds.size.width - 50, 40)];
    [infoLabel setBackgroundColor:[UIColor whiteColor]];
    [infoLabel setText:@"提示信息"];
    [infoLabel setTextAlignment:NSTextAlignmentCenter];
    [infoLabel setTextColor:[UIColor redColor]];
    [infoLabel setFont:[UIFont systemFontOfSize:14]];
    [infoLabel.layer setBorderWidth:1.0];
    [infoLabel.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:infoLabel];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)loginByWX
{
    [[GTSDKManager getAuthService:GTSDKPlatformWeChat]
     loginToPlatformWithCallback:^(NSDictionary *oauthInfo, NSDictionary *userInfo,
                                   NSError *error) {
         if (error == nil) {
             if (userInfo == nil && oauthInfo != nil) {
                 [infoLabel setText:@"授权成功"];
             } else {
                 NSString *alet =
                 [NSString stringWithFormat:@"昵称：%@  头像url：%@",
                  [userInfo objectForKey:kWX_NICKNAME_KEY],
                  [userInfo objectForKey:kWX_AVATARURL_KEY]];
                 NSLog(@"message = %@", alet);
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆成功"
                                                                     message:alet
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:@"Cancel", nil];
                 [alertView show];
             }
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)loginByQQ
{
    [[GTSDKManager getAuthService:GTSDKPlatformQQ]
     loginToPlatformWithCallback:^(NSDictionary *oauthInfo, NSDictionary *userInfo,
                                   NSError *error) {
         if (error == nil) {
             if (userInfo == nil && oauthInfo != nil) {
                 [infoLabel setText:@"授权成功"];
             } else {
                 NSString *alet =
                 [NSString stringWithFormat:@"昵称：%@  头像url：%@",
                  [userInfo objectForKey:kQQ_NICKNAME_KEY],
                  [userInfo objectForKey:kQQ_AVATARURL_KEY]];
                 NSLog(@"message = %@", alet);
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆成功"
                                                                     message:alet
                                                                    delegate:self
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:@"Cancel", nil];
                 [alertView show];
             }
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByQQ
{
    NSLog(@"shareByQQ");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey, @"text", GTSDKShareContentTextKey,
                               nil];
    [[GTSDKManager getShareService:GTSDKPlatformQQ]
     shareWithContent:shareDict
     shareModule:GTSDKShareToContact
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByWX
{
    NSLog(@"shareByWX");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey, @"text", GTSDKShareContentTextKey,
                               nil];
    [[GTSDKManager getShareService:GTSDKPlatformWeChat]
     shareWithContent:shareDict
     shareModule:GTSDKShareToContact
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByQzone
{
    NSLog(@"shareByWX");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey, @"text", GTSDKShareContentTextKey,
                               nil];
    [[GTSDKManager getShareService:GTSDKPlatformQQ]
     shareWithContent:shareDict
     shareModule:GTSDKShareToTimeLine
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByWXTimeline
{
    NSLog(@"shareByWX");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey, @"text", GTSDKShareContentTextKey,
                               nil];
    [[GTSDKManager getShareService:GTSDKPlatformWeChat]
     shareWithContent:shareDict
     shareModule:GTSDKShareToTimeLine
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByYXTimeline
{
    NSLog(@"shareByWX");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey, @"text", GTSDKShareContentTextKey,
                               nil];
    [[GTSDKManager getShareService:GTSDKPlatformYiXin]
     shareWithContent:shareDict
     shareModule:GTSDKShareToTimeLine
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByYX
{
    NSLog(@"shareByYX");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey, @"text", GTSDKShareContentTextKey,
                               nil];
    [[GTSDKManager getShareService:GTSDKPlatformYiXin]
     shareWithContent:shareDict
     shareModule:GTSDKShareToContact
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)shareByWeibo
{
    NSLog(@"shareByWeibo");
    NSDictionary *shareDict = [NSDictionary
                               dictionaryWithObjectsAndKeys:@"测试分享", GTSDKShareContentTitleKey,
                               @"测试分享详情", GTSDKShareContentDescriptionKey,
                               @"www.baidu.com", GTSDKShareContentWapUrlKey,
                               [UIImage imageNamed:@"Icon-Netease"],
                               GTSDKShareContentImageKey,
                               @"#网易彩票客户端# 双色球开奖啦！http://cp.163.com/d",
                               GTSDKShareContentTextKey, @"http://caipiao.163.com/m",
                               GTSDKShareContentRedirectURIKey, nil];
    [[GTSDKManager getShareService:GTSDKPlatformWeibo]
     shareWithContent:shareDict
     shareModule:GTSDKShareToContact
     onComplete:^(BOOL success, NSError *error) {
         if (success) {
             [infoLabel setText:@"分享成功"];
         } else {
             [infoLabel setText:error.localizedDescription];
         }
     }];
}

- (void)payByWX
{
    

    [[GTSDKManager getPayService:GTSDKPlatformWeChat]
     payOrder:@""
     callback:^(NSString *signString, NSError *error) {
         if (error) {
             [infoLabel setText:error.localizedDescription];
         } else if (signString) {
             [infoLabel setText:signString];
         }
     }];
}

- (void)payByAli
{

    NSString *sign = @"";
    [[GTSDKManager getPayService:GTSDKPlatformAliPay] payOrder: sign
     callback:^(NSString *signString, NSError *error) {
         if (error) {
             [infoLabel setText:error.localizedDescription];
         } else if (signString) {
             [infoLabel setText:signString];
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"click");
    alertView = nil;
}


@end
