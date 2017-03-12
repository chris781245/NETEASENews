//
//  NewsTableViewController.m
//  NETEASENews
//
//  Created by 史泽东 on 2017/3/10.
//  Copyright © 2017年 史泽东. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsCell.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"

@interface NewsTableViewController ()

// 新闻列表数据源
@property (nonatomic, strong) NSArray *newsModelArray;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void) setupTableView {
    
   // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseCell" bundle:nil] forCellReuseIdentifier:@"baseCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BigImageCell" bundle:nil] forCellReuseIdentifier:@"bigImageCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImagesCell" bundle:nil] forCellReuseIdentifier:@"imagesCell"];

}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    
    [NewsModel requestNewsModelArrayWithUrlStr:urlStr andCompletionBlock:^(NSArray *modelArray) {
        self.newsModelArray = modelArray;
        
        // 获取到数据
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsModelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsTableViewCell *cell;
    
    NewsModel *model = self.newsModelArray[indexPath.row];
    
    if (model.imgType) {
        
        // 大图
        cell = [tableView dequeueReusableCellWithIdentifier:@"bigImageCell" forIndexPath:indexPath];
        
    } else if (model.imgextra.count == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"imagesCell" forIndexPath:indexPath];
        
    } else {
        
        // 基础cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"baseCell" forIndexPath:indexPath];
    }
    
    cell.newsModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsModel *model = self.newsModelArray[indexPath.row];
    
    if (model.imgType) {
        
        // 大图
        return 130;
        
    } else if (model.imgextra.count == 2) {
        
        // 多图
        return 180;
        
    } else {
        
        // 基础cell
        return 80;
    
    }
    
}




@end
