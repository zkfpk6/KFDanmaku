//
//  KFFlyCommentView.m
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "KFFlyCommentView.h"

@interface KFFlyCommentView ()

@property (nonatomic, strong) NSArray *trackSpeedArray;
@property (nonatomic, assign) CGFloat trackHorizontalPadding;
@property (nonatomic, assign) CGFloat trackVerticalPadding;
@property (nonatomic, assign) CGFloat trackHeight;
@property (nonatomic, strong) NSMutableArray *trackArray;

@end


@implementation KFFlyCommentView

- (instancetype)initWithFrame:(CGRect)frame
       trackHorizontalPadding:(CGFloat)trackHorizontalPadding
         trackVerticalPadding:(CGFloat)trackVerticalPadding
                  trackHeight:(CGFloat)trackHeight
              trackSpeedArray:(NSArray *)trackSpeedArray {
    self = [super initWithFrame:frame];
    if (self) {
        _trackArray = @[].mutableCopy;
        _trackHorizontalPadding = trackHorizontalPadding;
        _trackVerticalPadding = trackVerticalPadding;
        _trackHeight = trackHeight;
        _trackSpeedArray = trackSpeedArray;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    for (int i = 0; i < self.trackSpeedArray.count; i++) {
        //把轨道按照间距加到baseview上，再加到数组中
        KFFlyCommentTrackView *trackView = [[KFFlyCommentTrackView alloc] initWithFrame:CGRectMake(0, (self.trackHeight + self.trackVerticalPadding) * i, self.frame.size.width, self.trackHeight)];
        trackView.trackHorizontalPadding = self.trackHorizontalPadding;
        trackView.speedPerSecond = [self.trackSpeedArray[i] floatValue];
        [self addSubview:trackView];
        [self.trackArray addObject:trackView];
        
        if (self.trackSpeedArray.count - 1 == i) {
            CGRect frame = self.frame;
            frame.size.height = CGRectGetMaxY(trackView.frame);
            self.frame = frame;
        }
    }
}

- (void)stop {
    //然后移除所有轨道的弹幕
    for (KFFlyCommentTrackView *trackView in self.trackArray) {
        [trackView cleanTrack];
    }
}

/**
 插入一条弹幕，可以插入任意继承UIView的对象
 
 @param customView 自定义的view（注意，最高不能超过轨道的高，否则会出问题。轨道的高度请在FlyCommentViewConfig.h中配置）
 @param trackIndex 插入弹幕的轨道（为-1则代表自动寻找最不拥挤的轨道插入）
 */
- (void)appendFlyCommentWithCustomView:(KFFlyCommentBulletBaseView *)customView toTrackIndex:(NSInteger)trackIndex {
    if (![customView isKindOfClass:KFFlyCommentBulletBaseView.class]) {
        return;
    }
    NSInteger realTrackIndex = trackIndex;
    if (realTrackIndex == -1) {
        //找到最不拥挤的轨道序号
        realTrackIndex = [self findTheMinTotalWidthTrack];
    }
    
    KFFlyCommentTrackView *trackView = _trackArray[realTrackIndex];
    [trackView appendFlyCommentWithCustomView:customView];
}

/**
 找到最短右侧出屏幕和等待数组总长度最短的轨道序号

 @return 轨道的序号
 */
- (int)findTheMinTotalWidthTrack {
    KFFlyCommentTrackView *firstTrackView = self.trackArray[0];
    int minWidthIndex = 0;
    float minWidth = [firstTrackView rightOutScreenWidth];
    for (int i = 0; i<_trackArray.count; i++) {
        KFFlyCommentTrackView *trackView = self.trackArray[i];
        float trackRightOutScreenWidth = [trackView rightOutScreenWidth];
        if (trackRightOutScreenWidth < minWidth) {
            minWidth = trackRightOutScreenWidth;
            minWidthIndex = i;
        }
        
    }
    return minWidthIndex;
}

- (void)dealloc {
    NSLog(@"KFFlyCommentView dealloc");
}

@end
