Pod::Spec.new do |s|
  s.name             = 'GTSDKManager'
  s.version          = '0.0.1'
  s.summary          = '第三方SDK统一管理组件'
  s.homepage         = 'https://github.com/liuxc123/GTSDKManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuxc123' => 'lxc_work@126.com' }
  s.source           = { :git => 'https://github.com/liuxc123/GTSDKManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  s.static_framework  =  true


  #组件对外提供服务接口
  s.subspec 'CoreService' do |ss|
    ss.public_header_files = 'GTSDKManager/CoreService/GTSDKManager.h',
    'GTSDKManager/CoreService/SDKServiceInterface/*.h'
    ss.source_files = 'GTSDKManager/CoreService/**/*.{h,m,mm}'
    ss.resources = ['GTSDKManager/CoreService/SDKServiceConfig.plist']
  end


  #QQ平台SDK集成
  s.subspec 'QQPlatform' do |ss|
    ss.public_header_files = 'GTSDKManager/QQPlatform/*.h','GTSDKManager/QQPlatform/**/*.h'
    ss.source_files = 'GTSDKManager/QQPlatform/**/*.{h,m,mm}'
    ss.vendored_frameworks = 'GTSDKManager/QQPlatform/GTQQSDK/TencentOpenAPI.framework'
    ss.resources = ['GTSDKManager/QQPlatform/**/*.{bundle}']
    ss.ios.frameworks = 'CoreTelephony', 'SystemConfiguration'
    ss.ios.libraries = 'z', 'sqlite3.0', 'c++', 'iconv'
    ss.dependency 'GTSDKManager/CoreService'
  end

  #微信平台SDK集成
  s.subspec 'WechatPlatform' do |ss|
    ss.public_header_files = 'GTSDKManager/WechatPlatform/WeChatSDK/*.h'
    ss.source_files = 'GTSDKManager/WechatPlatform/**/*.{h,m,mm}'
    ss.vendored_library = 'GTSDKManager/WechatPlatform/WeChatSDK/libWeChatSDK.a'
    ss.frameworks = 'MobileCoreServices', 'SystemConfiguration'
    ss.libraries = 'z', 'sqlite3.0', 'c++'
    ss.dependency 'GTSDKManager/CoreService'
  end

  #支付宝平台SDK集成
  s.subspec 'AlipayPlatform' do |ss|
    ss.public_header_files = 'GTSDKManager/AlipayPlatform/*.h','GTSDKManager/AlipayPlatform/**/*.h'
    ss.source_files = 'GTSDKManager/AlipayPlatform/**/*{h,m,mm}'
    ss.vendored_frameworks = 'GTSDKManager/AlipayPlatform/AlipaySDK/AlipaySDK.framework'
    ss.resources = ['GTSDKManager/AlipayPlatform/**/*.{bundle}']
    ss.frameworks = 'SystemConfiguration'
    ss.dependency 'GTSDKManager/CoreService'
  end

  #新浪微博平台SDK集成
  s.subspec 'WeiboPlatform' do |ss|
    ss.public_header_files = 'GTSDKManager/WeiboPlatform/libWeiboSDK/*.h'
    ss.source_files = 'GTSDKManager/WeiboPlatform/**/*{h,m,mm}'
    ss.vendored_library = 'GTSDKManager/WeiboPlatform/libWeiboSDK/libWeiboSDK.a'
    ss.resources = ['GTSDKManager/WeiboPlatform/**/*.{bundle}']
    ss.framework = 'QuartzCore','ImageIO','SystemConfiguration','Security','CoreTelephony','CoreText'
    ss.libraries = 'z', 'sqlite3.0'
    ss.dependency 'GTSDKManager/CoreService'
  end

  #易信平台SDK集成
  s.subspec 'YixinPlatform' do |ss|
    ss.public_header_files = 'GTSDKManager/YixinPlatform/YiXinSDK/*.h'
    ss.source_files = 'GTSDKManager/YixinPlatform/**/*.{h,m,mm}'
    ss.vendored_library = 'GTSDKManager/YixinPlatform/YiXinSDK/libYixinSDK.a'
    ss.dependency 'GTSDKManager/CoreService'
  end

  #钉钉平台SDK集成
  s.subspec 'DingTalkPlatform' do |ss|
    ss.source_files = 'GTSDKManager/DingTalkPlatform/**/*.{h,m,mm}'
    ss.vendored_frameworks = 'GTSDKManager/DingTalkPlatform/DingTalkSDK/DTShareKit.framework'
    ss.dependency 'GTSDKManager/CoreService'
  end

end
