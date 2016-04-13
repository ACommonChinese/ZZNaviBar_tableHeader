//
//  ThirdViewController.m
//  Demo
//
//  Created by 刘威振 on 4/12/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ThirdViewController.h"
#import "HFStretchableTableHeaderView.h"

#define NAVBAR_CHANGE_POINT 50
#define kTableHeaderHeight 260
#define kNaviBarHeight 64

@interface ThirdViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) HFStretchableTableHeaderView *stretchable;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}

- (void)initData {
    self.dataArray = [NSMutableArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"eleven", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", nil];
}

- (void)initUI {
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // navigation bar
    self.title           = @"好友动态";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame     = CGRectMake(0, 0, 60, 30);
    [leftButton setTitle:@"◀︎ 动态" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    // table view
    CGRect frame              = self.view.bounds;
    self.tableView            = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate   = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    // table header view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kTableHeaderHeight)];
    imageView.image = [UIImage imageNamed:@"bg.jpg"];
    self.tableView.tableHeaderView = imageView;
    
    // stretchable
    self.stretchable = [HFStretchableTableHeaderView new];
    [self.stretchable stretchHeaderForTableView:self.tableView withView:self.tableView.tableHeaderView];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.stretchable scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [self.stretchable resizeView];
}

@end
