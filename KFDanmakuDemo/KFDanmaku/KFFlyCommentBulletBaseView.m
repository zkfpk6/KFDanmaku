//
//  KFFlyCommentBulletBaseView.m
//  SmartEstateCC
//
//  Created by 张楷枫 on 2020/12/7.
//  Copyright © 2020 pretang. All rights reserved.
//

#import "KFFlyCommentBulletBaseView.h"

@implementation KFFlyCommentBulletBaseView

- (void)startWithStateChangedBlock:(void (^)(KFFlyCommentBulletState))success {
    
    self.state = KFFlyCommentBulletStateBegan;
    
    if (success) {
        success(self.state);
    }
    
    self.center = CGPointMake(self.center.x, self.superview.frame.size.height / 2.0);
    CGRect frame = self.frame;
    frame.origin.x = self.superview.frame.size.width;
    self.frame = frame;
    
    CGFloat totalDuration = (self.frame.size.width + self.trackWidth) / self.speedPerSecond;
    CGFloat enterDuration = (self.frame.size.width + self.trackHorizontalPadding ) / self.speedPerSecond;
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.aDealloc) {
            return;
        }
        strongSelf.state = KFFlyCommentBulletStateEnter;
        if (success) {
            success(strongSelf.state);
        }
    });
    
    [UIView animateWithDuration:totalDuration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        CGRect frame = strongSelf.frame;
        frame.origin.x = -strongSelf.frame.size.width;
        strongSelf.frame = frame;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.aDealloc) {
            return;
        }
        strongSelf.state = KFFlyCommentBulletStateEnd;
        if (success) {
            success(strongSelf.state);
        }
    }];
}

- (void)dealloc {
    NSLog(@"KFFlyCommentBulletBaseView dealloc");
}

@end
