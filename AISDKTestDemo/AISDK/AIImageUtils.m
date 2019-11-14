//
//  AIImageUtils.m
//  PunchCard
//
//  Created by Albin on 2019/7/10.
//  Copyright © 2019 Albin. All rights reserved.
//

#import "AIImageUtils.h"

@implementation AIImageUtils


+ (NSString *)dataToBase64:(NSData *)data{
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)imageToBase64:(UIImage *)image compressionQuality:(CGFloat)compressionQuality {
    NSData *data = UIImageJPEGRepresentation(image, compressionQuality);
    return [self dataToBase64:data];
}

+ (NSString *)imageToBase64:(UIImage *)image compressionQuality:(CGFloat)compressionQuality isUrlencode:(BOOL )isUrlencode {
    NSString *base64Str = [self imageToBase64:image compressionQuality:compressionQuality];
    if (isUrlencode) {
        NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
        NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
        base64Str= [base64Str stringByAddingPercentEncodingWithAllowedCharacters:set];
        base64Str= [base64Str stringByAddingPercentEncodingWithAllowedCharacters:set];
    }
    return base64Str;
}



@end
