//
//  NetworkTool.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool

+ (instancetype) shareTool {
    
    static NetworkTool *tool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[NetworkTool alloc] initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/article/list/"]];
    });
    
    return tool;
}

/**
 通用请求方法
 
 @param requestType 请求方式
 @param urlStr 请求地址
 @param parameters 请求参数
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 */
- (void)requestWithType: (RequestType)requestType andUrlStr: (NSString *)urlStr andParams: (id)parameters andSuccess: (void (^)(id responseObject))successBlock andFailture: (void (^)(NSError *error))failureBlock {
    
    if (requestType == GET) {
        [self GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
            
        }];
        
    } else {
        [self POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            successBlock(responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
            
        }];
    }
}

@end
