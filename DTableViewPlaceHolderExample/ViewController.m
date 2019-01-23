//
//  ViewController.m
//  DTableViewPlaceHolder
//
//  Created by Destiny on 2019/1/22.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "UITableView+PlaceHolder.h"
#import "EmptyStyleView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DTableViewPlaceHolderDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
     [self setUpMJRefresh];
}

- (void)setUpMJRefresh {
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf initData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", @"Random Data", self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark - 下拉刷新数据
- (void)initData{
     self.dataSource = nil;
    // 2.模拟1秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView d_reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadNewData {
    for (int i = 0; i<5; i++) {
        [self.dataSource insertObject:[NSString stringWithFormat:@"数据---%d", arc4random_uniform(1000000)] atIndex:0];
    }
    // 2.模拟1秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView d_reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - DTableViewPlaceHolderDelegate
- (UIView *)makePlaceHolderView {
    EmptyStyleView *view = [EmptyStyleView loadXibView];
    view.emptyOverlayClicked = ^{
        [self loadNewData];
    };
    return view;
}
- (BOOL)enableScrollWhenPlaceHolderViewShowing{
    return NO;
}

@end
