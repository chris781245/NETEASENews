//
//  ChannelModel.h
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

// 频道id
@property (nonatomic, copy) NSString *tid;

// 频道名称
@property (nonatomic, copy) NSString *tname;

// 获取频道模型数据
+ (NSArray *)getChannelModelArray;

@end
