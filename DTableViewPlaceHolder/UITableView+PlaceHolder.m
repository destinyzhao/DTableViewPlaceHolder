//
//  UITableView+PlaceHolder.m
//  DTableViewPlaceHolder
//
//  Created by Destiny on 2019/1/22.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import "UITableView+PlaceHolder.h"
#import <objc/runtime.h>

@interface UITableView ()

/**占位图*/
@property (nonatomic, strong) UIView *placeHolderView;

@end


@implementation UITableView (PlaceHolder)

- (UIView *)placeHolderView {
    return objc_getAssociatedObject(self, @selector(placeHolderView));
}

- (void)setPlaceHolderView:(UIView *)placeHolderView {
    objc_setAssociatedObject(self, @selector(placeHolderView), placeHolderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)d_reloadData {
    [self reloadData];
    [self d_checkEmpty];
}

- (void)d_checkEmpty {
    BOOL isEmpty = YES;
    
    id<UITableViewDataSource> src = self.dataSource;
    NSInteger sections = 1;
    // 获取sections
    if ([src respondsToSelector: @selector(numberOfSectionsInTableView:)]) {
        sections = [src numberOfSectionsInTableView:self];
    }
    // 获取rows
    for (int i = 0; i<sections; ++i) {
        NSInteger rows = [src tableView:self numberOfRowsInSection:i];
        // 如果rows不为零
        if (rows > 0) {
            isEmpty = NO;
            break;
        }
        
    }
    
    // 如果rows为空
    if (isEmpty) {
    
        // 模式ScrollView可以滚动
        BOOL scrollEnabled = YES;
        if ([self respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
            scrollEnabled = [self performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
        }
        else if ([self.delegate respondsToSelector:@selector(enableScrollWhenPlaceHolderViewShowing)]) {
            scrollEnabled = [self.delegate performSelector:@selector(enableScrollWhenPlaceHolderViewShowing)];
        }
        self.scrollEnabled = scrollEnabled;
        
        // 移除placeHolderView
        [self.placeHolderView removeFromSuperview];
        // 获取placeHolderView
        if ([self respondsToSelector:@selector(makePlaceHolderView)]) {
            self.placeHolderView = [self performSelector:@selector(makePlaceHolderView)];
        }
        else if ( [self.delegate respondsToSelector:@selector(makePlaceHolderView)]) {
            self.placeHolderView = [self.delegate performSelector:@selector(makePlaceHolderView)];
        }
        self.placeHolderView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.placeHolderView];
    }
    else {
        // rows不为空 移除placeHolderView
        [self.placeHolderView removeFromSuperview];
        self.placeHolderView = nil;
        // 设置TableView 可滚动
        self.scrollEnabled = YES;
    }
}

@end
