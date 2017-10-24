//
//  YYPictureCoverView.m
//  优悦一族
//
//  Created by liang on 2017/7/26.
//  Copyright © 2017年 umed. All rights reserved.
//

#import "CLPictureCoverView.h"

@interface CLPictureCoverView ()
@property (nonatomic, strong) UIImageView *icon;

@end
@implementation CLPictureCoverView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (UIView *)customView {
    
    if (!_icon) {
        
        _icon = [[UIImageView alloc] init];
        _icon.frame = self.bounds;
    }
    return _icon;
}
@end

