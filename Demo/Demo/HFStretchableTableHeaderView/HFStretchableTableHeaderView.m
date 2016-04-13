//
//  StretchableTableHeaderView.m
//  StretchableTableHeaderView
//

#import "HFStretchableTableHeaderView.h"

@interface HFStretchableTableHeaderView()
{
    CGRect initialFrame;
    CGFloat defaultViewHeight;
}
@end


@implementation HFStretchableTableHeaderView

@synthesize tableView = _tableView;
@synthesize view = _view;

/**
 * tableView: 表格
 * view: 传入进来的表格的headerView
 */
- (void)stretchHeaderForTableView:(UITableView*)tableView withView:(UIView*)view
{
    _tableView = tableView;
    _view = view;
    
    initialFrame       = _view.frame;
    defaultViewHeight  = initialFrame.size.height;
    
    // 第一步：把headerView用一个空视图代替
    UIView *emptyTableHeaderView = [[UIView alloc] initWithFrame:initialFrame];
    _tableView.tableHeaderView = emptyTableHeaderView;
    
    // 第二步：把headerView作为子视图加到tableView上
    [_tableView addSubview:_view];
}

// 第三步：当托动tableView的时候，让子视图的frame相应的发生变化
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGRect f     = _view.frame;
    f.size.width = _tableView.frame.size.width;
    _view.frame  = f;
    
    if(scrollView.contentOffset.y < 0) {
        CGFloat offsetY = (scrollView.contentOffset.y + scrollView.contentInset.top) * -1;
        NSLog(@"offsetY: %lf", offsetY);
//        initialFrame.origin.y = offsetY * -1;
//        initialFrame.size.height = defaultViewHeight + offsetY;
//        _view.frame = initialFrame;
        CGRect frame = _view.frame;
        frame.origin.y = offsetY * -1;
        frame.size.height = defaultViewHeight + offsetY;
        _view.frame = frame;
    }
}

- (void)resizeView
{
    // initialFrame.size.width = _tableView.frame.size.width;
    // _view.frame = initialFrame; // 宽度等于tableView的宽度
}


@end
