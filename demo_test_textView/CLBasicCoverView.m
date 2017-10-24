//
//  YYBasicCoverView.m
//  优悦一族
//
//  Created by liang on 2017/3/30.
//  Copyright © 2017年 umed. All rights reserved.
//

#import "CLBasicCoverView.h"

@implementation CLBasicCoverView

- (instancetype)init {
    
    self = [super init];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}
- (void)showForView:(UIView *)view {
    
    if ([self checkExistInView:view]) {
        return;
    }
    if (view) {
        self.frame = view.bounds;
        [self addSubview:self.customView];
        [view addSubview:self];
    }
}

- (BOOL)checkExistInView:(UIView *)view {
    
    __block BOOL exit = NO;
    NSArray *array = view.subviews;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[CLBasicCoverView class]]) {
            
            exit = YES;
            *stop = YES;
        }
    }];
    return exit;
}

- (void)close {
    
    if (self.closeAction) {
        
        __weak CLBasicCoverView *_self = self;
        self.closeAction(_self);
        self.closeAction = nil;
        self.clickAction = nil;
    }
    [self removeFromSuperview];
}
- (UIView *)customView {
    
    NSParameterAssert(@"subclass must inhert this method");
    return nil;
}

- (void)dealloc {
    
#ifdef DEBUG
    
    NSLog(@"cover view dealloc:%@",[self class]);
#endif
}

@end

