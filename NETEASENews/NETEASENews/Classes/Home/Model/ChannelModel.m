//
//  ChannelModel.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "ChannelModel.h"
#import <YYModel.h>

@implementation ChannelModel

+ (NSArray *)getChannelModelArray {
    
    // 获取json文件路径
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    // 获取文件对应的二进制数据
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    
    // 反序列化
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
    
    // 获取tlist对应的数据
    NSArray *channelDicArray = [dic objectForKey:@"tList"];
    
    // 使用yymodel完成字典转模型
    NSArray *modelArray = [NSArray yy_modelArrayWithClass:[ChannelModel class] json:channelDicArray];
    
    // 根据模型里的tid进行从小到大的排序
    modelArray = [modelArray sortedArrayUsingComparator:^NSComparisonResult(ChannelModel *obj1, ChannelModel *obj2) {
        
        return [obj1.tid compare:obj2.tid];
        
    }];
    
    return modelArray;
}

- (NSString *)description {
    
    NSString *desc = [NSString stringWithFormat:@"%@--%@", self.tid, self.tname];
    return desc;
}

@end
