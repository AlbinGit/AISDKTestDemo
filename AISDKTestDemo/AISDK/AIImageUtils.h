//
//  AIImageUtils.h
//  PunchCard
//
//  Created by Albin on 2019/7/10.
//  Copyright © 2019 Albin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AIImageUtils : NSObject


/**
 把imageData转化成Base64

 @param data data
 @return Base64
 */
+ (NSString *)dataToBase64:(NSData *)data;

/**
 把image转化成Base64

 @param image image
 @param compressionQuality 压缩比例（0——1） 1表示不压缩
 @return Base64
 */
+ (NSString *)imageToBase64:(UIImage *)image compressionQuality:(CGFloat)compressionQuality;


/**
 把image转化成Base64

 @param image image image
 @param compressionQuality compressionQuality 压缩比例（0——1） 1表示不压缩
 @param isUrlencode isUrlencode
 @return Base64Str
 */
+ (NSString *)imageToBase64:(UIImage *)image compressionQuality:(CGFloat)compressionQuality isUrlencode:(BOOL )isUrlencode;

@end

NS_ASSUME_NONNULL_END
