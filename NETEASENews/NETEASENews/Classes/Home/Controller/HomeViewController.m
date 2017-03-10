//
//  HomeViewController.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "HomeViewController.h"
#import "ChannelModel.h"
#import "ChannelLabel.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *channelView;

@property (weak, nonatomic) IBOutlet UICollectionView *newsView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

//频道数据源
@property (nonatomic, strong) NSArray *channelModelArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestChannelData];
}

- (void) requestChannelData {
    
    // 记录频道数据源
    self.channelModelArray = [ChannelModel getChannelModelArray];
    
    // 遍历频道模型数组，创建对应label
        // 设置label宽高
    CGFloat labelWidth = 80;
    CGFloat labelHeight = 44;
    
    for (NSInteger i = 0; i < self.channelModelArray.count; i++) {
        
        // 获取对应的模型数据
        ChannelModel *model = self.channelModelArray[i];
        
        // 创建label
        ChannelLabel *channelLabel = [[ChannelLabel alloc] initWithFrame:CGRectMake(i * labelWidth, 0, labelWidth, labelHeight)];
        
        channelLabel.text = model.tname;
        
        // 设置文字大小和居中方式
        channelLabel.font = [UIFont systemFontOfSize:15];
        channelLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.channelView addSubview:channelLabel];
    }
    
    // 设置channelView滚动范围
    self.channelView.contentSize = CGSizeMake(self.channelModelArray.count * labelWidth, 0);
    
    // 取消滚动指示器
    self.channelView.showsVerticalScrollIndicator = NO;
    self.channelView.showsHorizontalScrollIndicator = NO;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
