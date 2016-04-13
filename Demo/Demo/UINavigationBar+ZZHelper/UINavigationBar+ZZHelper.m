//
//  UINavigationBar+ZZHelper.m
//  导航Demo
//
//  Created by 刘威振 on 4/12/16.
//  Copyright © 2016 愤怒的振振. All rights reserved.
//

#import "UINavigationBar+ZZHelper.h"
#import <objc/runtime.h>

@interface UINavigationBar ()

@property (nonatomic) UIView *overlay;
@end

@implementation UINavigationBar (ZZHelper)

- (UIView *)overlay {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOverlay:(UIView *)overlay {
    objc_setAssociatedObject(self, @selector(overlay), overlay, OBJC_ASSOCIATION_RETAIN);
}

- (void)zz_setBackgroundColor:(UIColor *)color {
    if (!self.overlay) {
        // 第一步：设置一个空图片背景
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        // 第二步：为了影响到状态栏，加一层
        CGFloat statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -statusBarHeight, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + statusBarHeight)];
        self.overlay.userInteractionEnabled = NO;
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
        
        // 第三步：隐藏导航条的线
        // http://www.4byte.cn/question/448208/how-to-hide-ios7-uinavigationbar-1px-bottom-line.html
        [self setShadowImage:UIImage.new];
    }
    self.overlay.backgroundColor = color;
}

- (void)zz_setOffsetY:(CGFloat)offset {
    self.backIndicatorImage = nil;
    CGFloat height = self.frame.size.height;
    if (offset > 0) {
        if (offset >= height) {
            self.transform = CGAffineTransformMakeTranslation(0, -height);
            [self zz_setElementsAlpha:0.0];
        } else {
            self.transform = CGAffineTransformMakeTranslation(0, - offset);
            [self zz_setElementsAlpha:1 - offset / height];
        }
    } else {
        self.transform = CGAffineTransformIdentity;
        self.backIndicatorImage = UIImage.new;
        [self zz_setElementsAlpha:1.0];
    }
}

- (void)zz_setElementsAlpha:(CGFloat)alpha {
    /**
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
    }];
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    NSLog(@"%@", titleView);
    titleView.backgroundColor = [UIColor redColor];
    titleView.alpha = alpha;
     */
    self.alpha = alpha;
}

@end
