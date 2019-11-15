//
//  LCNetworking.h
//  LCNetworking
//
//  Created by lichao on 2017/3/3.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id responseObject);
typedef void (^FailureBlock)(NSString *error);


@interface AINetworking : NSObject

//原生GET网络请求
+ (void)getWithURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+ (void)PostWithURL:(NSString *)url Params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure;

+ (void)PostWithURL:(NSString *)url Params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure isUrlencode:(BOOL )isUrlencode;

@end
