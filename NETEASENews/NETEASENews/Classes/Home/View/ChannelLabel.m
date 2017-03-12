//
//  ChannelLabel.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "ChannelLabel.h"

@implementation ChannelLabel

- (void)setScalePercent:(CGFloat)scalePercent {
    
    _scalePercent = scalePercent;
    
    self.textColor = [UIColor colorWithRed:scalePercent green:0 blue:0 alpha:1];
    
    // 计算缩放比，最小是1
    CGFloat currentScalePercent = 1 + scalePercent * 0.3;
    
    self.transform = CGAffineTransformMakeScale(currentScalePercent, currentScalePercent );
}

@end
