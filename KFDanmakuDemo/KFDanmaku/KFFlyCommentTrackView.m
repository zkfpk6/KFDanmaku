//
//  KFFlyCommentTrackView.m
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "KFFlyCommentTrackView.h"

@interface KFFlyCommentTrackView ()

@property (nonatomic, strong) KFFlyCommentBulletBaseView *currentBulletView;

/**
 等待出现到屏幕中的弹幕view数组
 */
@property (nonatomic, strong) NSMutableArray *waitShowArray;

@end

@implementation KFFlyCommentTrackView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _waitShowArray = @[].mutableCopy;
    }
    return self;
}

- (void)appendFlyCommentWithCustomView:(KFFlyCommentBulletBaseView *)view {
    [self.waitShowArray addObject:view];
    if (self.running) {
        return;
    }
    [self startBullet:self.nextBullet];
}

- (void)startBullet:(KFFlyCommentBulletBaseView *)view {
    self.running = YES;
    view.speedPerSecond = self.speedPerSecond;
    view.trackWidth = self.frame.size.width;
    view.trackHorizontalPadding = self.trackHorizontalPadding;
    self.currentBulletView = view;
    __weak typeof(self) weakSelf = self;
    __weak KFFlyCommentBulletBaseView *weakView = view;
    [view startWithStateChangedBlock:^(KFFlyCommentBulletState state) {
        if (self.running == NO) {
            return;
        }
        switch (state) {
            case KFFlyCommentBulletStateBegan:
                [weakSelf addSubview:weakView];
                break;
                
            case KFFlyCommentBulletStateEnter:
                if (weakSelf.haveNextBullet) {
                    [weakSelf startBullet:weakSelf.nextBullet];
                    return;
                }
                weakSelf.currentBulletView = nil;
                weakSelf.running = NO;
                break;
                
            case KFFlyCommentBulletStateEnd:
                [weakView removeFromSuperview];
                break;
        }
    }];
}

- (KFFlyCommentBulletBaseView *)nextBullet {
    if (self.waitShowArray.count) {
        KFFlyCommentBulletBaseView *bulletView = self.waitShowArray[0];
        [self.waitShowArray removeObjectAtIndex:0];
        return bulletView;
    }
    return nil;
}

- (BOOL)haveNextBullet {
    return self.waitShowArray.count == 0 ? NO : YES;
}

/**
 这个方法可以拿出所有右侧尚未出现的弹幕和出现在最右侧的那一条弹幕的长度和
 
 @return 长度和
 */
- (float)rightOutScreenWidth
{
    CGFloat totalWidth = 0;
    for (KFFlyCommentBulletBaseView *view in _waitShowArray) {
        totalWidth += (view.frame.size.width + _trackHorizontalPadding);
    }
    if (self.currentBulletView) {
        //判断如果最右侧的那条弹幕还没有完全出现在屏幕中
        if (CGRectGetMaxX(self.currentBulletView.layer.presentationLayer.frame) + self.trackHorizontalPadding > self.frame.size.width || _waitShowArray.count) {
            CGFloat outScreenWidth = self.currentBulletView.layer.presentationLayer.frame.origin.x + self.currentBulletView.layer.presentationLayer.frame.size.width - self.frame.size.width + _trackHorizontalPadding;
            totalWidth += outScreenWidth;
        }
    }
    return totalWidth;
}

//清理轨道
- (void)cleanTrack {
    self.running = NO;
    for (KFFlyCommentBulletBaseView *view in self.subviews) {
        view.aDealloc = YES;
        [view removeFromSuperview];
    }

    [_waitShowArray removeAllObjects];
}

- (void)dealloc {
    NSLog(@"KFFlyCommentTrackView dealloc");
}

@end
