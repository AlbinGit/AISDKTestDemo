//
//  AISDKManager.m
//  PunchCard
//
//  Created by Albin on 2019/7/2.
//  Copyright © 2019 Albin. All rights reserved.
//

#import "AISDKManager.h"
#import "AINetworking.h"

#define Domain @"http://aicgi.wo186.tv" //https://aip.baidubce.com ，http://182.254.204.70:8300，http://cgi.platomix.net
//#define Domain @"https://aip.baidubce.com"

@interface AISDKManager()

@property (nonatomic ,copy) NSString *token;

@end

@implementation AISDKManager


+ (instancetype)sharedInstance {
    static AISDKManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AISDKManager alloc] init];
    });
    return manager;
}

- (void)initWithLicenseID:(NSString *)licenseId andLocalLicenceFile:(NSString *)localLicencePath completion:(AICompletion)completion{
    NSDictionary *parameters = @{@"grant_type":@"client_credentials",
                                 @"client_id":licenseId,
                                 @"client_secret":localLicencePath,
                                 };
    [AINetworking PostWithURL:Domain@"/oauth/2.0/token" Params:parameters success:^(id responseObject) {
        NSString *token = responseObject[@"access_token"];
        if (token) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"AISDK_access_token"];
        }
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        NSLog(@"%@",error);
        if (completion) {
            completion(error);
        }
    }];
}


//人脸检测
- (void)faceDetectParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/detect",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//活体检测
- (void)faceLivenessParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/liveness",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//人脸对比
- (void)faceMatchParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/match",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//人脸搜索
- (void)faceIdentifyParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/identify",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//人脸注册
- (void)faceAddParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/add",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//人脸更新
- (void)faceUpdateParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/update",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//人脸列表
- (void)faceListParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/list",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//删除人脸
- (void)faceDeleteParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/delete",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//复制用户
- (void)userCopyParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/user/copy",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//获取用户信息
- (void)userGetParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/user/get",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//用户列表
- (void)userListParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/user/list",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}
//删除用户
- (void)userDeleteParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/user/delete",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//创建用户组
- (void)groupAddParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/group/add",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//删除用户组
- (void)groupDeleteParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/group/delete",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

//组列表
- (void)groupListParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/group/list",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

/**
 人体关键点识别
 
 @param parameters 图片
 @param completion 识别结果
 */
- (void)body_analysisWithParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/rest/2.0/image-classify/v1/body_analysis",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

/**
 人体检测和属性识别
 
 @param parameters 图片
 @param completion 识别结果
 */
- (void)body_attrWithParameters:(id)parameters completion:(AICompletion)completion {
    NSString *url = [NSMutableString stringWithFormat:@"%@/rest/2.0/image-classify/v1/body_attr",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

/**
 人流量统计
 
 @param parameters 图片
 @param completion 识别结果
 */
- (void)body_numWithParameters:(id)parameters completion:(AICompletion)completion {
    NSString *url = [NSMutableString stringWithFormat:@"%@/rest/2.0/image-classify/v1/body_num",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}

/**
 手势识别
 
 @param parameters 图片
 @param completion 识别结果
 */
- (void)gestureWithParameters:(id)parameters completion:(nonnull AICompletion)completion {
    NSString *url = [NSMutableString stringWithFormat:@"%@/rest/2.0/image-classify/v1/gesture",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
//        GestureType type = unkown;
//        NSArray *result = responseObject[@"result"];
//        if (result.count>0) {
//            NSString *classname = result[0][@"classname"];
//            if ([classname isEqualToString:@"One"]) {
//                type = One;
//            }else if ([classname isEqualToString:@"Five"]){
//                type = Five;
//            }else if ([classname isEqualToString:@"Fist"]){
//                type = Fist;
//            }else if ([classname isEqualToString:@"Ok"]){
//                type = OK;
//            }else if ([classname isEqualToString:@"Prayer"]){
//                type = Prayer;
//            }else if ([classname isEqualToString:@"Congratulation"]){
//                type = Congratulation;
//            }else if ([classname isEqualToString:@"Honour"]){
//                type = Honour;
//            }else if ([classname isEqualToString:@"Heart_single"]){
//                type = Heart_single;
//            }else if ([classname isEqualToString:@"Thumb_up"]){
//                type = Thumb_up;
//            }else if ([classname isEqualToString:@"Thumb_down"]){
//                type = Thumb_down;
//            }else if ([classname isEqualToString:@"ILY"]){
//                type = ILY;
//            }else if ([classname isEqualToString:@"Palm_up"]){
//                type = Palm_up;
//            }else if ([classname isEqualToString:@"Heart_1"]){
//                type = Heart_1;
//            }else if ([classname isEqualToString:@"Heart_2"]){
//                type = Heart_2;
//            }else if ([classname isEqualToString:@"Heart_3"]){
//                type = Heart_3;
//            }else if ([classname isEqualToString:@"Two"]){
//                type = Two;
//            }else if ([classname isEqualToString:@"Three"]){
//                type = Three;
//            }else if ([classname isEqualToString:@"Four"]){
//                type = Four;
//            }else if ([classname isEqualToString:@"Six"]){
//                type = Six;
//            }else if ([classname isEqualToString:@"Seven"]){
//                type = Seven;
//            }else if ([classname isEqualToString:@"Eight"]){
//                type = Eight;
//            }else if ([classname isEqualToString:@"Nine"]){
//                type = Nine;
//            }else if ([classname isEqualToString:@"Rock"]){
//                type = Rock;
//            }else if ([classname isEqualToString:@"Insult"]){
//                type = Insult;
//            }
//        }
//        if (completion) {
//            completion(type);
//        }
    } failure:^(NSString *error) {
//        if (completion) {
//            completion(unkown);
//        }
        if (completion) {
            completion(error);
        }
    }];
}

//在线活体检测
- (void)liveBodyDetectParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/v3/face/liveness",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


//h5活体检测
- (void)h5BodyDetectParameters:(id)parameters completion:(AICompletion)completion{
    NSString *url = [NSMutableString stringWithFormat:@"%@/face-api/face/liveness",Domain];
    [AINetworking PostWithURL:url Params:parameters success:^(id responseObject) {
        if (completion) {
            completion(responseObject);
        }
    } failure:^(NSString *error) {
        if (completion) {
            completion(error);
        }
    }];
}


/**
 图片转换成NSData

 @param image 图片
 @return NSData
 */
- (NSData *)p_imageToData:(UIImage *)image{
    NSData *data = UIImageJPEGRepresentation(image, 0.1);
    return data;
}

@end
