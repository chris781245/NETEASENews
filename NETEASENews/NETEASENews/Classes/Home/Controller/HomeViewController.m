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
#import "NewsCell.h"

@interface HomeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *channelView;

@property (weak, nonatomic) IBOutlet UICollectionView *newsView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

//频道数据源
@property (nonatomic, strong) NSArray *channelModelArray;

// 记录频道标签
@property (nonatomic, strong) NSMutableArray *channelLabelArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self requestChannelData];
    [self setupNewsCollectionView];
}

- (void) requestChannelData {
    
    // 记录频道数据源
    self.channelModelArray = [ChannelModel getChannelModelArray];
    
    // 初始化频道数组
    self.channelLabelArray = [NSMutableArray array];
    
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
        
        // 开启用户交互
        channelLabel.userInteractionEnabled = YES;
        
        // 创建手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapChannelLabelAction:)];
        
        // 添加手势
        [channelLabel addGestureRecognizer:tapGesture];
        
        // 设置tag
        channelLabel.tag = i;
        
        // 记录频道label
        [self.channelLabelArray addObject:channelLabel];
        
        // 表示头条新闻
        if (i == 0) {
            channelLabel.scalePercent = 1;
        }
        
    }
    
    // 设置channelView滚动范围
    self.channelView.contentSize = CGSizeMake(self.channelModelArray.count * labelWidth, 0);
    
    // 取消滚动指示器
    self.channelView.showsVerticalScrollIndicator = NO;
    self.channelView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 点击频道获取对应的新闻
- (void) tapChannelLabelAction: (UITapGestureRecognizer *)gesture {
    
    // 获取频道label
    ChannelLabel *channelLabel = (ChannelLabel *)gesture.view;
    [self scrollChannelLabel:channelLabel];
    
    // 创建滚动的indexPath
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:channelLabel.tag inSection:0];
    
    [self.newsView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    // 遍历频道数组，判断点击的频道和数组里的频道是否匹配， 匹配则放大，否则显示默认状态
    for (ChannelLabel *label in self.channelLabelArray) {
        if (channelLabel == label) {
            label.scalePercent = 1;
        } else {
            label.scalePercent = 0;
        }
    }
    
}

#pragma mark - 滚动标签，让频道居中 uiscrollview delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 计算滚动页数的索引
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 根据索引获取频道标签
    ChannelLabel *channelLabel = self.channelLabelArray[index];
    
    [self scrollChannelLabel:channelLabel];
    
}

- (void) scrollChannelLabel: (ChannelLabel *)channelLabel {
    
    // 获取label的中心X
    CGFloat channelLabelCenterX = channelLabel.center.x;
    
    // 计算滚动出去的距离
    CGFloat contentOffsetX = channelLabelCenterX - self.view.frame.size.width * 0.5;
    
    // 设置最小滚动范围 和 最大滚动范围
    CGFloat contentOffsetMinX = 0;
    CGFloat contentOffsetMaxX = self.channelView.contentSize.width - self.view.frame.size.width;
    
    // 比最小小等于最小， 比最大大等于最大
    if (contentOffsetX < contentOffsetMinX) {
        contentOffsetX = contentOffsetMinX;
    }
    if (contentOffsetX > contentOffsetMaxX) {
        contentOffsetX = contentOffsetMaxX;
    }
    
    // 频道滚动到指定位置
    [self.channelView setContentOffset:CGPointMake(contentOffsetX, 0) animated:YES];

}

#pragma mark -- newsView滚动 标签字体缩放，渐变色
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 计算小数索引
    CGFloat floatIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 计算整数索引
    int index = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    // 获取百分比
    CGFloat percent = floatIndex - index;
    
    // 计算左边标签的百分比
    CGFloat leftPercent = 1 - percent;
    
    // 计算右边标签的百分比
    CGFloat rightPercent = percent;
    
    // 计算左边标签索引
    int leftIndex = index;
    
    // 计算右边标签索引
    int rightIndex = index + 1;
    
    // 根据指定索引获取标签
    ChannelLabel *leftChannelLabel = self.channelLabelArray[leftIndex];
    
    // 设置左边标签的缩放百分比
    leftChannelLabel.scalePercent = leftPercent;
    
    // 判断右边频道的标签是否超出可用的取值范围
    if (rightIndex < self.channelLabelArray.count) {
        ChannelLabel *rightChannelLabel = self.channelLabelArray[rightIndex];
        rightChannelLabel.scalePercent = rightPercent;
    }
}

// 设置新闻视图
- (void) setupNewsCollectionView {
    
    self.newsView.dataSource = self;
    self.newsView.delegate = self;
    
    // 设置每个item的大小
    self.flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
    
    // 设置垂直间距，水平间距
    self.flowLayout.minimumLineSpacing = 0;
    self.flowLayout.minimumInteritemSpacing = 0;
    
    // 设置滚动方式
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 开启分页效果
    self.newsView.pagingEnabled = YES;
    
    // 去掉弹簧效果
    self.newsView.bounces = NO;
    
    // 去掉滚动条
    self.newsView.showsVerticalScrollIndicator = NO;
    self.newsView.showsHorizontalScrollIndicator = NO;
    
}


#pragma mark - UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.channelModelArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCell" forIndexPath:indexPath];
    
    // 获取指定频道模型
    ChannelModel *model = self.channelModelArray[indexPath.item];
    
    // 获取频道id
    NSString *tid = model.tid;
    
    // 获取请求地址
    NSString *urlStr = [NSString stringWithFormat:@"%@/0-20.html", tid];
    
    cell.urlStr = urlStr;
    
    return cell;
}

@end
