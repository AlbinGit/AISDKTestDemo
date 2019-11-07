//
//  LCNetworking.m
//  LCNetworking
//
//  Created by lichao on 2017/3/3.
//  Copyright © 2017年 lichao. All rights reserved.
//

#import "AINetworking.h"

#pragma mark -

@interface LZQueryStringPair : NSObject
@property (readwrite, nonatomic, strong) id field;
@property (readwrite, nonatomic, strong) id value;

- (instancetype)initWithField:(id)field value:(id)value;

- (NSString *)URLEncodedStringValue;
@end

@implementation LZQueryStringPair

- (instancetype)initWithField:(id)field value:(id)value {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.field = field;
    self.value = value;
    
    return self;
}

- (NSString *)URLEncodedStringValue {
    if (!self.value || [self.value isEqual:[NSNull null]]) {
        return LZPercentEscapedStringFromString([self.field description]);
    } else {
        return [NSString stringWithFormat:@"%@=%@", LZPercentEscapedStringFromString([self.field description]), LZPercentEscapedStringFromString([self.value description])];
    }
}

NSString * LZPercentEscapedStringFromString(NSString *string) {
    static NSString * const kLZCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
    static NSString * const kLZCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:[kLZCharactersGeneralDelimitersToEncode stringByAppendingString:kLZCharactersSubDelimitersToEncode]];
    
    // FIXME: https://github.com/LZNetworking/LZNetworking/pull/3028
    // return [string stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    static NSUInteger const batchSize = 50;
    
    NSUInteger index = 0;
    NSMutableString *escaped = @"".mutableCopy;
    
    while (index < string.length) {
        NSUInteger length = MIN(string.length - index, batchSize);
        NSRange range = NSMakeRange(index, length);
        
        // To avoid breaking up character sequences such as 👴🏻👮🏽
        range = [string rangeOfComposedCharacterSequencesForRange:range];
        
        NSString *substring = [string substringWithRange:range];
        NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
        [escaped appendString:encoded];
        
        index += range.length;
    }
    
    return escaped;
}

@end


NSString *const ResponseErrorKey = @"com.alamofire.serialization.response.error.response";
NSInteger const Interval = 30;

@interface AINetworking ()

@end

@implementation AINetworking

//原生GET网络请求
+ (void)getWithURL:(NSString *)url Params:(NSDictionary *)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    //完整URL
    NSString *urlString = [NSString string];
    if (params) {
        //参数拼接url
        NSString *paramStr = [self dealWithParam:params];
        urlString = [url stringByAppendingString:paramStr];
    }else{
        urlString = url;
    }
    //对URL中的中文进行转码
    NSString *pathStr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:pathStr]];
    
    request.timeoutInterval = Interval;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                //利用iOS自带原生JSON解析data数据 保存为Dictionary
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                success(dict);
                
            }else{
                NSHTTPURLResponse *httpResponse = error.userInfo[ResponseErrorKey];
                
                if (httpResponse.statusCode != 0) {
                    
                    NSString *ResponseStr = [self showErrorInfoWithStatusCode:httpResponse.statusCode];
                    failure(ResponseStr);
                    
                } else {
                    NSString *ErrorCode = [self showErrorInfoWithStatusCode:error.code];
                    failure(ErrorCode);
                }
            }

        });
    }];
    
    [task resume];
}

//原生POST请求
+ (void)PostWithURL:(NSString *)url Params:(id)params success:(SuccessBlock)success failure:(FailureBlock)failure{

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
   
    if ([url containsString:@"image-classify"]) {
        NSString *jsonString = [self urlencodedStrByDic:params];
        NSData *bodyData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];//把bodyString转换为NSData数据
        [request setHTTPBody:bodyData];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    } else {
        //json格式
        NSData *bodyData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        //设置请求体
        [request setHTTPBody:bodyData];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%ld", bodyData.length] forHTTPHeaderField:@"Content-Length"];
    }
    
    //表单格式
    //把字典中的参数进行拼接
//    NSString *body = LZQueryStringFromParameters(params);
//    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding];
    //设置请求体
//    [request setHTTPBody:bodyData];
    //设置本次请求的数据请求格式
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    // 设置本次请求请求体的长度(因为服务器会根据你这个设定的长度去解析你的请求体中的参数内容)
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"AISDK_access_token"];
    [request setValue:token forHTTPHeaderField:@"access_token"];

    //设置请求最长时间
    request.timeoutInterval = Interval;
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     
        if (data) {
            //利用iOS自带原生JSON解析data数据 保存为Dictionary
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                success(dict);
            });
        }else{
            NSHTTPURLResponse *httpResponse = error.userInfo[ResponseErrorKey];
            
            if (httpResponse.statusCode != 0) {
                
                NSString *ResponseStr = [self showErrorInfoWithStatusCode:httpResponse.statusCode];
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(ResponseStr);
                });
                
            } else {
                NSString *ErrorCode = [self showErrorInfoWithStatusCode:error.code];
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(ErrorCode);
                });
            }
        }
    }];
    [task resume];
}

#pragma mark -- 拼接参数
+ (NSString *)dealWithParam:(NSDictionary *)param
{
    NSMutableArray *array = [NSMutableArray array];
    NSArray *allkeys = [param allKeys];
    for (NSString *key in allkeys) {
        NSString *string = [NSString stringWithFormat:@"%@=%@", key, param[key]];
        [array addObject:string];
    }
    return [array componentsJoinedByString:@"&"];
}

NSString * LZQueryStringFromParameters(NSDictionary *parameters) {
    NSMutableArray *mutablePairs = [NSMutableArray array];
    for (LZQueryStringPair *pair in LZQueryStringPairsFromDictionary(parameters)) {
        [mutablePairs addObject:[pair URLEncodedStringValue]];
    }
    
    return [mutablePairs componentsJoinedByString:@"&"];
}

NSArray * LZQueryStringPairsFromDictionary(NSDictionary *dictionary) {
    return LZQueryStringPairsFromKeyAndValue(nil, dictionary);
}

NSArray * LZQueryStringPairsFromKeyAndValue(NSString *key, id value) {
    NSMutableArray *mutableQueryStringComponents = [NSMutableArray array];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES selector:@selector(compare:)];
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = value;
        // Sort dictionary keys to ensure consistent ordering in query string, which is important when deserializing potentially ambiguous sequences, such as an array of dictionaries
        for (id nestedKey in [dictionary.allKeys sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            id nestedValue = dictionary[nestedKey];
            if (nestedValue) {
                [mutableQueryStringComponents addObjectsFromArray:LZQueryStringPairsFromKeyAndValue((key ? [NSString stringWithFormat:@"%@[%@]", key, nestedKey] : nestedKey), nestedValue)];
            }
        }
    } else if ([value isKindOfClass:[NSArray class]]) {
        NSArray *array = value;
        for (id nestedValue in array) {
            [mutableQueryStringComponents addObjectsFromArray:LZQueryStringPairsFromKeyAndValue([NSString stringWithFormat:@"%@[]", key], nestedValue)];
        }
    } else if ([value isKindOfClass:[NSSet class]]) {
        NSSet *set = value;
        for (id obj in [set sortedArrayUsingDescriptors:@[ sortDescriptor ]]) {
            [mutableQueryStringComponents addObjectsFromArray:LZQueryStringPairsFromKeyAndValue(key, obj)];
        }
    } else {
        [mutableQueryStringComponents addObject:[[LZQueryStringPair alloc] initWithField:key value:value]];
    }
    
    return mutableQueryStringComponents;
}

#pragma mark
+ (NSString *)showErrorInfoWithStatusCode:(NSInteger)statusCode{
    
    NSString *message = nil;
    switch (statusCode) {
        case 401: {
        
        }
            break;
            
        case 500: {
            message = @"服务器异常！";
        }
            break;
            
        case -1001: {
            message = @"网络请求超时，请稍后重试！";
        }
            break;
            
        case -1002: {
            message = @"不支持的URL！";
        }
            break;
            
        case -1003: {
            message = @"未能找到指定的服务器！";
        }
            break;
            
        case -1004: {
            message = @"服务器连接失败！";
        }
            break;
            
        case -1005: {
            message = @"连接丢失，请稍后重试！";
        }
            break;
            
        case -1009: {
            message = @"互联网连接似乎是离线！";
        }
            break;
            
        case -1012: {
            message = @"操作无法完成！";
        }
            break;
            
        default: {
            message = @"网络请求发生未知错误，请稍后再试！";
        }
            break;
    }
    return message;
    
}

+ (NSString *)urlencodedStrByDic:(NSDictionary *)dic {
    NSArray *array = [dic allKeys];
    NSMutableArray *muArr = [NSMutableArray array];
    for (NSString *key in array) {
        NSString *value = dic[key];
        [muArr addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
    }
    return [muArr componentsJoinedByString:@"&"];
}

@end


