//
//  SecondViewController.m
//  Demo
//
//  Created by 刘威振 on 4/12/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "SecondViewController.h"
#import "UINavigationBar+ZZHelper.h"

#define NAVBAR_CHANGE_POINT 50
#define kTableHeaderHeight 260
#define kNaviBarHeight 64

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;
@end

@implementation SecondViewController

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
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // 导航条
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    // table view
    CGRect frame   = self.view.bounds;
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    [self.view addSubview:self.tableView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kTableHeaderHeight)];
    // imageView.image = [UIImage imageNamed:@"headerImage.png"];
    imageView.image = [UIImage imageNamed:@"bg.jpg"];
    self.tableView.tableHeaderView = imageView;
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [doneButton setFrame:CGRectMake(0, 0, 40, 40)];
    [doneButton setTitle:@"OK" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:nil action:nil];
    
    self.navigationItem.title = @"Second";
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
    CGFloat offsetY = scrollView.contentOffset.y;
    [self.navigationController.navigationBar zz_setOffsetY:offsetY];
}

@end
