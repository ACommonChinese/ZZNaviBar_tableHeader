//
//  ViewController.m
//  Demo
//
//  Created by 刘威振 on 4/12/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "FirstViewController.h"
#import "UINavigationBar+ZZHelper.h"

#define NAVBAR_CHANGE_POINT 50
#define kTableHeaderHeight 260
#define kNaviBarHeight 64

@interface FirstViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;
@end

@implementation FirstViewController

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
    
    // [self.navigationController.navigationBar setTranslucent:YES];
    // [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
    
    // 导航条
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [self.navigationController.navigationBar zz_setBackgroundColor:[UIColor clearColor]];
    
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
    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    self.navigationItem.title = @"First";
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
    /**
     CGFloat offsetY       = scrollView.contentOffset.y - self.tableView.frame.origin.y;
     CGFloat criticalPoint = kTableHeaderHeight - 2*kNaviBarHeight; // 临界点
     CGFloat value         = offsetY - criticalPoint > 0 ? offsetY - criticalPoint : 0;
     
     if (offsetY > criticalPoint) {
     CGFloat alpha = MIN(1, value/kNaviBarHeight);
     [self.navigationController.navigationBar zz_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
     } else {
     [self.navigationController.navigationBar zz_setBackgroundColor:[color colorWithAlphaComponent:0]];
     }*/
    
    CGFloat offsetY       = scrollView.contentOffset.y - self.tableView.frame.origin.y;
    CGFloat criticalPoint = kTableHeaderHeight - kNaviBarHeight; // 临界点
    if (offsetY > criticalPoint) {
        [self.navigationController.navigationBar zz_setBackgroundColor:color];
    } else {
        [self.navigationController.navigationBar zz_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

@end
