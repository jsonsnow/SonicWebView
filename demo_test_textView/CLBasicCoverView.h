//
//  YYBasicCoverView.h
//  优悦一族
//
//  Created by liang on 2017/3/30.
//  Copyright © 2017年 umed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLBasicCoverView : UIView
@property (nonatomic, copy) void(^closeAction)(CLBasicCoverView *);
@property (nonatomic, copy) void(^clickAction)(CLBasicCoverView *,UIView *);
@property (nonatomic, strong) UIView *customView;

- (void)showForView:(UIView *)view;
- (void)close;
@end

