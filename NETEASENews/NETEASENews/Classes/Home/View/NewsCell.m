//
//  NewsCell.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "NewsCell.h"
#import "NewsTableViewController.h"

@implementation NewsCell {
    NewsTableViewController *_tableViewVC;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 创建新闻列表控制器
    _tableViewVC = [[NewsTableViewController alloc] init];
    
    [self.contentView addSubview: _tableViewVC.tableView];
    
    // 设置控制器视图大小
    _tableViewVC.tableView.frame = self.contentView.bounds;
    
    // 设置tableview的随机颜色
    _tableViewVC.tableView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
}

- (void)setUrlStr:(NSString *)urlStr {
    
    _urlStr = urlStr;
    
    // 获取请求地址
    _tableViewVC.urlStr = urlStr;
}

@end
