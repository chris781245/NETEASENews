//
//  NewsTableViewCell.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/12.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "NewsTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface NewsTableViewCell ()

// 新闻图片
@property (weak, nonatomic) IBOutlet UIImageView *imgsrcImageView;

// 新闻标题
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

// 新闻来源
@property (weak, nonatomic) IBOutlet UILabel *lblSource;

// 回复数
@property (weak, nonatomic) IBOutlet UILabel *lblReplyCount;

@end

@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 设置图片按控件大小显示
    self.imgsrcImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgsrcImageView.clipsToBounds = YES;
    
}

- (void)setNewsModel:(NewsModel *)newsModel {
    
    _newsModel = newsModel;
    
    [self.imgsrcImageView sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    self.lblTitle.text = newsModel.title;
    self.lblSource.text = newsModel.source;
    self.lblReplyCount.text = [NSString stringWithFormat:@"%zd", newsModel.replyCount];
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
