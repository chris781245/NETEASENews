//
//  NewsTableViewCell.h
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/12.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
// 自定义新闻列表cell
@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, strong) NewsModel *newsModel;

@end
