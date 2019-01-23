//
//  EmptyStyleView.m
//  DTableViewPlaceHolder
//
//  Created by Destiny on 2019/1/22.
//  Copyright © 2019 Destiny. All rights reserved.
//

#import "EmptyStyleView.h"

@implementation EmptyStyleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)loadXibView
{
    EmptyStyleView *view = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    return view;
}

- (IBAction)btnAction:(UIButton *)sender {
    NSLog(@"点击了按钮");
    if(self.emptyOverlayClicked){
        self.emptyOverlayClicked();
    }
}

@end
