//
//  EmptyStyleView.h
//  DTableViewPlaceHolder
//
//  Created by Destiny on 2019/1/22.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EmptyOverlayClicked)(void);

NS_ASSUME_NONNULL_BEGIN

@interface EmptyStyleView : UIView

@property (copy, nonatomic) EmptyOverlayClicked emptyOverlayClicked;

+ (instancetype)loadXibView;

@end

NS_ASSUME_NONNULL_END
