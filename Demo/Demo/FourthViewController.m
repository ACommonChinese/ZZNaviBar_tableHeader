//
//  FourthViewController.m
//  Demo
//
//  Created by 刘威振 on 4/13/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "FourthViewController.h"
#import "UITableView+ZZStretchableHeader.h"
#import "UINavigationBar+ZZHelper.h"

#define NAVBAR_CHANGE_POINT 50
#define kTableHeaderHeight 260
#define kNaviBarHeight 64

@interface FourthViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;
@end

@implementation FourthViewController

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
    
    // 导航条
    self.navigationItem.title = @"好友动态";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    leftButton.frame     = CGRectMake(0, 0, 60, 30);
    [leftButton setTitle:@"◀︎ 动态" forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar zz_setBackgroundColor:[UIColor clearColor]];
    
    
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
    
    self.tableView.headerViewStretchable = YES;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIColor *color        = [UIColor colorWithRed:0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY       = scrollView.contentOffset.y - self.tableView.frame.origin.y;
    CGFloat criticalPoint = kTableHeaderHeight - kNaviBarHeight; // 临界点
    if (offsetY > criticalPoint) {
        [self.navigationController.navigationBar zz_setBackgroundColor:color];
    } else {
        [self.navigationController.navigationBar zz_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

@end
