//
//  ViewController.m
//  AISDKTestDemo
//
//  Created by Albin on 2019/7/11.
//  Copyright © 2019 Albin. All rights reserved.
//

#import "ViewController.h"
#import "AISDKManager.h"
#import "AIImageUtils.h"

@interface ViewController ()

- (IBAction)faceDetect:(id)sender;

- (IBAction)faceLiveness:(id)sender;

- (IBAction)faceMatch:(id)sender;

- (IBAction)faceIdentify:(id)sender;

- (IBAction)faceAdd:(id)sender;

- (IBAction)faceUpdate:(id)sender;

- (IBAction)faceList:(id)sender;

- (IBAction)faceDelete:(id)sender;

- (IBAction)userCopy:(id)sender;

- (IBAction)userGet:(id)sender;

- (IBAction)userList:(id)sender;

- (IBAction)userDelete:(id)sender;

- (IBAction)groupAdd:(id)sender;

- (IBAction)groupDelete:(id)sender;

- (IBAction)groupList:(id)sender;

@property (nonatomic ,copy) NSString *imageBase64;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"timg.jpeg"];
    _imageBase64 = [AIImageUtils imageToBase64:image compressionQuality:1];
//    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
//    NSData *videoData = [NSData dataWithContentsOfFile:videoPath];
//    NSString *videoBase64 = [AIImageUtils dataToBase64:videoData];

}

- (void)faceDetect{
    //人脸检测
    [[AISDKManager sharedInstance] faceDetectParameters:@{@"image":_imageBase64,
                                                          @"image_type":@"BASE64",
                                                          @"ace_field":@"age",
                                                          }
                                             completion:^(id  _Nonnull result) {
                                                 NSLog(@"%@",result);
                                                 [self showAlert:result];
                                             }];
}

//活体检测
- (void)faceLiveness{
        [[AISDKManager sharedInstance] faceLivenessParameters:@{@"image":_imageBase64,
                                                                @"image_type":@"BASE64",
                                                                @"ace_field":@"age",
                                                                } completion:^(id  _Nonnull result) {
            NSLog(@"%@",result);
                                                                    [self showAlert:result];
        }];
}

- (void)faceMatch {
    //人脸对比
    [[AISDKManager sharedInstance] faceMatchParameters:@[@{@"image":_imageBase64,
                                                           @"image_type":@"BASE64",
                                                           @"face_type":@"LIVE",
                                                           @"quality_control":@"LOW",
                                                           @"liveness_control":@"HIGH"
                                                           },
                                                         @{@"image":_imageBase64,
                                                           @"image_type":@"BASE64",
                                                           @"face_type":@"LIVE",
                                                           @"quality_control":@"LOW",
                                                           @"liveness_control":@"HIGH"
                                                           }] completion:^(id  _Nonnull result) {
                                                               NSLog(@"%@",result);
                                                               [self showAlert:result];
                                                           }];
}

- (void)faceAdd {
    //人脸注册
    [[AISDKManager sharedInstance] faceAddParameters:@{@"image":_imageBase64,
                                                       @"image_type":@"BASE64",
                                                       @"group_id":@"group_repeat",
                                                       @"user_id":@"user1",
                                                       @"user_info":@"abc",
                                                       @"quality_control":@"LOW",
                                                       @"liveness_control":@"NORMAL",
                                                       } completion:^(id  _Nonnull result) {
                                                           NSLog(@"%@",result);
                                                           [self showAlert:result];
                                                       }];
}

- (void)groupAdd {
    //创建用户组
    [[AISDKManager sharedInstance] groupAddParameters:@{@"group_id":@"group_233",} completion:^(id  _Nonnull result) {
        NSLog(@"%@",result);
        [self showAlert:result];
    }];
}

- (void)faceIdentif {
    //人脸搜索
    [[AISDKManager sharedInstance] faceIdentifyParameters:@{@"image":_imageBase64,
                                                            @"image_type":@"BASE64",
                                                            @"group_id_list":@"group_repeat,group_233",
                                                            @"quality_control": @"LOW",
                                                            @"liveness_control": @"NORMAL"
                                                            } completion:^(id  _Nonnull result) {
                                                                NSLog(@"%@",result);
                                                                [self showAlert:result];
                                                            }];
}

//人脸更新 （param[group_id] is null）
- (void)faceUpdate{
    [[AISDKManager sharedInstance] faceUpdateParameters:@{@"image":_imageBase64,
                                                          @"image_type":@"BASE64",
                                                          @"group_id":@"group_repeat",
                                                          @"user_id" :@"user1",
                                                          @"user_info" :@"cba",
                                                          @"quality_control":@"LOW",
                                                          @"liveness_control":@"NORMAL",
                                                          } completion:^(id  _Nonnull result) {
                                                              NSLog(@"%@",result);
                                                              [self showAlert:result];
                                                          }];
}

//人脸列表
- (void)faceList {
    [[AISDKManager sharedInstance] faceListParameters:@{@"user_id":@"user1",
                                                        @"group_id":@"group_repeat",} completion:^(id  _Nonnull result) {
                                                            NSLog(@"%@",result);
                                                            [self showAlert:result];
    }];
}

//删除人脸
- (void)faceDelete{
    [[AISDKManager sharedInstance] faceDeleteParameters:@{@"user_id":@"user1",
                                                          @"group_id":@"group_repeat",
                                                          @"face_token":@"6a45bc7343cd4d279a5030425584f857"}
                                             completion:^(id  _Nonnull result) {
                                                 NSLog(@"%@",result);
                                                 [self showAlert:result];
    }];
}

//复制用户
- (void)userCopy {
    [[AISDKManager sharedInstance] userCopyParameters:@{@"user_id":@"user1",
                                                        @"src_group_id":@"group_repeat",
                                                        @"dst_group_id":@"group_233"} completion:^(id  _Nonnull result) {
        NSLog(@"%@",result);
                                                            [self showAlert:result];
    }];
}

//获取用户信息
- (void)userGet {
    [[AISDKManager sharedInstance] userGetParameters:@{@"user_id":@"user1",
                                                       @"group_id":@"group_233"}
                                          completion:^(id  _Nonnull result) {
                                              NSLog(@"%@",result);
                                              [self showAlert:result];
    }];
}

//用户列表
- (void)userList {
    [[AISDKManager sharedInstance] userListParameters:@{@"group_id":@"group_233"} completion:^(id  _Nonnull result) {
        NSLog(@"%@",result);
        [self showAlert:result];
    }];
}

//删除用户 404
-(void)userDelete {
    [[AISDKManager sharedInstance] userDeleteParameters:@{@"user_id":@"user1",
                                                          @"group_id":@"group_233"}
                                             completion:^(id  _Nonnull result) {
                                                 NSLog(@"%@",result);
                                                 [self showAlert:result];
    }];
}

//删除用户组
- (void)groupDelete {
    [[AISDKManager sharedInstance] groupDeleteParameters:@{@"group_id":@"group_233"} completion:^(id  _Nonnull result) {
        NSLog(@"%@",result);
        [self showAlert:result];
    }];
}


//组列表
- (void)groupList {
    [[AISDKManager sharedInstance] groupListParameters:@{@"start":@(0),
                                                         @"length":@(100)}
                                            completion:^(id  _Nonnull result) {
        NSLog(@"%@",result);
                                                [self showAlert:result];
    }];
}

/**
 人体关键点识别
 */
- (void)body_analysis {
    UIImage *image = [UIImage imageNamed:@"peoples"];
    NSString *imageBase64 = [AIImageUtils imageToBase64:image compressionQuality:0.1 isUrlencode:YES];
    [[AISDKManager sharedInstance] body_analysisWithParameters:@{@"image":imageBase64} completion:^(id  _Nonnull result) {
        [self showAlert:result];
    }];
}

/**
 人体检测和属性识别
 */
- (void)body_attr {
    UIImage *image = [UIImage imageNamed:@"people1"];
    NSString *imageBase64 = [AIImageUtils imageToBase64:image compressionQuality:0.5 isUrlencode:YES];
    NSString *type = @"gender,age,lower_wear,upper_wear,headwear,glasses,upper_color,lower_color,cellphone,upper_wear_fg,upper_wear_texture,lower_wear_texture,orientation,umbrella,bag,smoke,vehicle,carrying_item,upper_cut,lower_cut,occlusion,is_human";
    [[AISDKManager sharedInstance] body_attrWithParameters:@{@"image":imageBase64,
                                                             @"type":type,
                                                             } completion:^(id  _Nonnull result) {
                                                                 [self showAlert:result];
    }];
}

/**
 人流量统计
 */
- (void)body_num {
    UIImage *image = [UIImage imageNamed:@"people1"];
    NSString *imageBase64 = [AIImageUtils imageToBase64:image compressionQuality:0.1 isUrlencode:YES];
    [[AISDKManager sharedInstance] body_numWithParameters:@{@"image":imageBase64,} completion:^(id  _Nonnull result) {
        [self showAlert:result];
    }];
}

/**
 手势识别
 */
- (void)gesture {
    UIImage *image = [UIImage imageNamed:@"love.jpg"];
    NSString *imageBase64 = [AIImageUtils imageToBase64:image compressionQuality:1 isUrlencode:YES];
    [[AISDKManager sharedInstance] gestureWithParameters:@{@"image":imageBase64,
                                                           } completion:^(id  _Nonnull result) {
        [self showAlert:result];
    }];
}

/**
 在线活体检测
 */
- (void)liveBodyDetect {
    [[AISDKManager sharedInstance] liveBodyDetectParameters:@{@"image":_imageBase64,
                                                           @"image_type":@"BASE64",
                                                           } completion:^(id  _Nonnull result) {
                                                               [self showAlert:result];
                                                           }];
}

/**
 h5活体检测
 */
- (void)h5BodyDetect {
    UIImage *image = [UIImage imageNamed:@"love.jpg"];
    NSString *imageBase64 = [AIImageUtils imageToBase64:image compressionQuality:1 isUrlencode:YES];
    [[AISDKManager sharedInstance] h5BodyDetectParameters:@{@"image":imageBase64,
                                                           } completion:^(id  _Nonnull result) {
                                                               [self showAlert:result];
                                                           }];
}

- (void)showAlert:(id)result{
    NSString *jsonStr = nil;
    if (result) {
        NSData * data = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:nil];
       jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    } else {
        jsonStr = @"请求数据为空！";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:jsonStr message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       
    }]];
 
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}


- (IBAction)faceDetect:(id)sender {
    [self faceDetect];
}

- (IBAction)faceLiveness:(id)sender {
    [self faceLiveness];
}

- (IBAction)faceMatch:(id)sender {
    [self faceMatch];
}

- (IBAction)faceIdentify:(id)sender {
    [self faceIdentif];
}

- (IBAction)faceAdd:(id)sender {
    [self faceAdd];
}

- (IBAction)faceUpdate:(id)sender {
    [self faceUpdate];
}

- (IBAction)faceList:(id)sender {
    [self faceList];
}

- (IBAction)faceDelete:(id)sender {
    [self faceDelete];
}

- (IBAction)userCopy:(id)sender {
    [self userCopy];
}

- (IBAction)userGet:(id)sender {
    [self userGet];
}

- (IBAction)userList:(id)sender {
    [self userList];
}

- (IBAction)userDelete:(id)sender {
    [self userDelete];
}

- (IBAction)groupAdd:(id)sender {
    [self groupAdd];
}

- (IBAction)groupDelete:(id)sender {
    [self groupDelete];
}

- (IBAction)groupList:(id)sender {
    [self groupList];
}

- (IBAction)liveBodyDetect:(id)sender {
    [self liveBodyDetect];
}

- (IBAction)h5BodyDetect:(id)sender {
    [self h5BodyDetect];
}

- (IBAction)bodyKeypointDetect:(id)sender {
    [self body_analysis];
}

- (IBAction)bodyPropertyDetect:(id)sender {
    [self body_attr];
}

- (IBAction)bodyNumDetect:(id)sender {
    [self body_num];
}

- (IBAction)gestureDetect:(id)sender {
    [self gesture];
}






@end
