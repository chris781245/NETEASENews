//
//  NetworkTool.h
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum: NSInteger {
    
    GET,
    POST
} RequestType;

@interface NetworkTool : AFHTTPSessionManager

+ (instancetype) shareTool;

/**
 通用请求方法

 @param requestType 请求方式
 @param urlStr 请求地址
 @param parameters 请求参数
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 */
- (void)requestWithType: (RequestType)requestType andUrlStr: (NSString *)urlStr andParams: (id)parameters andSuccess: (void (^)(id responseObject))successBlock andFailture: (void (^)(NSError *error))failureBlock;

@end
