//
//  UIImage+GTSDKShare.h
//  GTSDKManager_Example
//
//  Created by liuxc on 2018/11/14.
//  Copyright © 2018 liuxc123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GTSDKShare)

- (UIImage *)GTSDKShare_resizedImage:(CGSize)newSize
                interpolationQuality:(CGInterpolationQuality)quality;

@end
