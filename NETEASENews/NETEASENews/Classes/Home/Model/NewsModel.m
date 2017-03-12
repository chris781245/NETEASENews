//
//  NewsModel.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "NewsModel.h"
#import "NetworkTool.h"
#import <YYModel.h>

@implementation NewsModel

// 根据指定请求地址获取新闻数据
+ (void)requestNewsModelArrayWithUrlStr: (NSString *)urlStr andCompletionBlock: (void(^)(NSArray *modelArray))completionBlock {
    
    [[NetworkTool shareTool] requestWithType:GET andUrlStr:urlStr andParams:nil andSuccess:^(id responseObject) {
        
        NSDictionary *dic = (NSDictionary *)responseObject;
        
        // 获取字典里的key
        NSString *key = dic.allKeys.firstObject;
        
        // 通过key获取新闻的数组字典
        NSArray *dicArray = [dic objectForKey:key];
        
        // 通过yymodel完成转模型
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[NewsModel class] json:dicArray];
        
        // 回调主线程 AFN回调主线程进行回调的
        completionBlock(modelArray);
        
    } andFailture:^(NSError *error) {
        
        NSLog(@"error: %@", error);
        
    }];
}

@end
