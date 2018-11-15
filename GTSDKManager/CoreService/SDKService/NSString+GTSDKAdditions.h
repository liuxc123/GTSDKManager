//
//  NSString+GTSDKAdditions.h
//  FBSnapshotTestCase
//
//  Created by liuxc on 2018/11/15.
//

#import <Foundation/Foundation.h>

@interface NSString (GTSDKAdditions)

- (BOOL)isEmptyOrWhitespace;

- (NSString *)URLEncodedString;

- (NSString *)URLDecodedString;

- (NSData *)base16Data;

- (NSString *)md5String;

- (NSDictionary *)urlParamsDecodeDictionary;

@end
