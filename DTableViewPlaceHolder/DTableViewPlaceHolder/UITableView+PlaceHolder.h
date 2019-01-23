//
//  UITableView+PlaceHolder.h
//  DTableViewPlaceHolder
//
//  Created by Destiny on 2019/1/22.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DTableViewPlaceHolderDelegate <NSObject>

@required

/**
 无数据占位图
 @return 占位图
 */
- (UIView *)makePlaceHolderView;

@optional

/**
 出现占位图的时候TableView是否能拖动
 @return BOOL
 */
- (BOOL)enableScrollWhenPlaceHolderViewShowing;

@end

@interface UITableView (PlaceHolder)

- (void)d_reloadData;

@end

NS_ASSUME_NONNULL_END
