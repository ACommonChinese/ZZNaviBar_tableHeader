//
//  UITableView+ZZStretchableHeader.m
//  Demo
//
//  Created by 刘威振 on 4/13/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "UITableView+ZZStretchableHeader.h"
#import <objc/runtime.h>

@interface UITableView ()

@property (nonatomic) float defaultHeaderHeight;
@property (nonatomic) UIView *headerView;
@end

@implementation UITableView (ZZStretchableHeader)

static NSString * const kvo_contentOffset = @"contentOffset";

#pragma mark - setter & getter
- (void)setHeaderViewStretchable:(BOOL)headerViewStretchable  {
    if (headerViewStretchable == NO) return;
    if (self.tableHeaderView == nil) return;
    
    // 第一步：把headerView用一个空视图代替
    UIView *headerView       = self.tableHeaderView;
    CGRect frame             = headerView.frame;
    self.defaultHeaderHeight = frame.size.height;
    UIView *emptyHeaderView  = [[UIView alloc] initWithFrame:frame];
    self.tableHeaderView     = emptyHeaderView;
    
    // 第二步：把headerView作为子视图加到tableView上
    self.headerView = headerView;
    [self addSubview:self.headerView];
    
    // KVO
    // [self willChangeValueForKey:kvo_contentOffset];
    objc_setAssociatedObject(self, @selector(headerViewStretchable), [NSNumber numberWithBool:headerViewStretchable], OBJC_ASSOCIATION_RETAIN);
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:kvo_contentOffset options:options context:nil];
    // [self didChangeValueForKey:kvo_contentOffset];
    
    // [self removeObservers]; // 旧的监听移除
    // [self removeObserver:self forKeyPath:kvo_contentOffset];
}

- (BOOL)headerViewStretchable {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDefaultHeaderHeight:(float)defaultHeaderHeight {
    objc_setAssociatedObject(self, @selector(defaultHeaderHeight), [NSNumber numberWithFloat:defaultHeaderHeight], OBJC_ASSOCIATION_RETAIN);
}

- (float)defaultHeaderHeight {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setHeaderView:(UIView *)headerView {
    objc_setAssociatedObject(self, @selector(headerView), headerView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)headerView {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if (!self.tableHeaderView) return;
    if (self.tableHeaderView.hidden) return;
    if ([keyPath isEqualToString:kvo_contentOffset]) {
        CGFloat contentOffSetY = [change[NSKeyValueChangeNewKey] CGPointValue].y;
        if (contentOffSetY < 0) {
            CGFloat offsetY   = (contentOffSetY + self.contentInset.top) * -1;
            CGRect frame      = self.headerView.frame;
            frame.origin.y    = -offsetY;
            frame.size.height = self.defaultHeaderHeight + offsetY;
            self.headerView.frame = frame;
        }
    }
}

@end
