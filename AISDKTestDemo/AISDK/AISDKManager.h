//
//  AISDKManager.h
//  PunchCard
//
//  Created by Albin on 2019/7/2.
//  Copyright © 2019 Albin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    unkown = 0,//未识别出来
    One,//数字1（原食指）
    Five,//数字5（原掌心向前）
    Fist,//拳头
    OK,//OK
    Prayer,//祈祷
    Congratulation,//作揖
    Honour,//作别
    Heart_single,//单手比心
    Thumb_up,//点赞
    Thumb_down,//Diss
    ILY,//我爱你
    Palm_up,//掌心向上
    Heart_1,//双手比心1
    Heart_2,//双手比心2
    Heart_3,//双手比心3
    Two,//数字2
    Three,//数字3
    Four,//数字4
    Six,//数字6
    Seven,//数字7
    Eight,//数字8
    Nine,//数字9
    Rock,//Rock
    Insult,//竖中指
} GestureType;


typedef void(^AICompletion) (id result);
typedef void(^AIGestureCompletion) (GestureType type);

@interface AISDKManager : NSObject



+ (instancetype)sharedInstance;

/**
 *  鉴权方法
 *  SDK鉴权方法 必须在使用其他方法之前设置，否则会导致SDK不可用
 *  @param licenseId 鉴权api key
 *  @param localLicencePath 本地鉴权文件路径Secret Key
 */
- (void)initWithLicenseID:(NSString *)licenseId andLocalLicenceFile:(NSString *)localLicencePath completion:(AICompletion)completion;

/**
 人脸检测

 @param parameters @{
 image:图片信息(数据大小应小于10M)
 image_type:图片类型 BASE64:图片的base64值;FACE_TOKEN: 人脸标识
 max_face_num:最多处理人脸的数目. 默认值为1，仅检测图片中面积最大的那个人脸 最大值10
 face_type:人脸的类型 LIVE表示生活照：通常为手机、相机拍摄的人像图片、或从网络获取的人像图片等,IDCARD表示身份证芯片照：二代身份证内置芯片中的人像照片 WATERMARK表示带水印证件照：一般为带水印的小图，如公安网小图 CERT表示证件照片：如拍摄的身份证、工卡、护照、学生证等证件图片 INFRARED 表示红外照片：使用红外相机拍摄的照片(此项功能暂未上线) 默认LIVE
 face_field:包括age,beauty,expression,face_shape,gender,glasses,landmark, race,quality,face_type,parsing,feature信息，逗号分隔. 默认只返回face_token、活体数、人脸框、概率和旋转角度
 }
 @param completion 返回参数
 */
- (void)faceDetectParameters:(id)parameters completion:(AICompletion)completion;

/**
 活体检测

 @param parameters @{
 image:base64编码后的视频数据（视频限制：最佳为上传5-15s的mp4文件。视频编码方式：h264编码；音频编码格式：aac，pcm均可。）
 image_type:视频文件 需要用post multipart/form-data的方式上传,video/video_base64必需选一个传入, 如同时传入时video字段优先
 }
 
 @param completion 返回参数
 */

- (void)faceLivenessParameters:(id)parameters completion:(AICompletion)completion;

/**
 人脸对比

 @param parameters @{
 image:图片信息(数据大小应小于10M)
 mage_type:图片类型BASE64:图片的base64值;FACE_TOKEN: 人脸标识
 }
 @param completion  返回参数
 */

- (void)faceMatchParameters:(id)parameters completion:(AICompletion)completion;

//人脸搜索(人脸认证)
- (void)faceIdentifyParameters:(id)parameters completion:(AICompletion)completion;

//人脸注册
- (void)faceAddParameters:(id)parameters completion:(AICompletion)completion;

//人脸更新
- (void)faceUpdateParameters:(id)parameters completion:(AICompletion)completion;

//人脸列表
- (void)faceListParameters:(id)parameters completion:(AICompletion)completion;

//删除人脸
- (void)faceDeleteParameters:(id)parameters completion:(AICompletion)completion;

//复制用户
- (void)userCopyParameters:(id)parameters completion:(AICompletion)completion;

//获取用户信息
- (void)userGetParameters:(id)parameters completion:(AICompletion)completion;

//用户列表
- (void)userListParameters:(id)parameters completion:(AICompletion)completion;

//删除用户
- (void)userDeleteParameters:(id)parameters completion:(AICompletion)completion;

//创建用户组
- (void)groupAddParameters:(id)parameters completion:(AICompletion)completion;

//删除用户组
- (void)groupDeleteParameters:(id)parameters completion:(AICompletion)completion;

//组列表
- (void)groupListParameters:(id)parameters completion:(AICompletion)completion;



/**
 人体关键点识别

 @param parameters 图片
 @param completion 识别结果
 */
- (void)body_analysisWithParameters:(id)parameters completion:(AICompletion)completion;

/**
 人体检测和属性识别

 @param parameters 图片
 @param completion 识别结果
 */
- (void)body_attrWithParameters:(id)parameters completion:(AICompletion)completion;

/**
 人流量统计

 @param parameters 图片
 @param completion 识别结果
 */
- (void)body_numWithParameters:(id)parameters completion:(AICompletion)completion;

/**
 手势识别

 @param parameters 图片
 @param completion 识别结果
 */
- (void)gestureWithParameters:(id)parameters completion:(AICompletion)completion;


//在线活体检测
- (void)liveBodyDetectParameters:(id)parameters completion:(AICompletion)completion;

//h5活体检测
- (void)h5BodyDetectParameters:(id)parameters completion:(AICompletion)completion;

@end

NS_ASSUME_NONNULL_END
