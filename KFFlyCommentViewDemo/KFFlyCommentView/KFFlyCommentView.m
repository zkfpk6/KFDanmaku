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
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat trackVerticalMargin;
@property (nonatomic, assign) CGFloat trackHorizontalPadding;
@property (nonatomic, assign) CGFloat trackHeight;
@property (nonatomic, assign) BOOL infinityLoop;
@property (nonatomic, strong) NSMutableArray *trackArray;

@end

@implementation KFFlyCommentView

- (instancetype)initWithFrame:(CGRect)frame
                 infinityLoop:(BOOL)infinityLoop
          trackVerticalMargin:(CGFloat)trackVerticalMargin
       trackHorizontalPadding:(CGFloat)trackHorizontalPadding
                  trackHeight:(CGFloat)trackHeight
              trackSpeedArray:(NSArray *)trackSpeedArray {
    self = [super initWithFrame:frame];
    if (self) {
        _trackSpeedArray = trackSpeedArray;
        _trackVerticalMargin = trackVerticalMargin;
        _trackHorizontalPadding = trackHorizontalPadding;
        _infinityLoop = infinityLoop;
        _trackHeight = trackHeight;
        _infinityLoop = infinityLoop;
        _trackArray = [[NSMutableArray alloc] init];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    for (int i = 0; i<_trackSpeedArray.count; i++) {
        //把轨道按照间距加到baseview上，再加到数组中
        KFFlyCommentTrackView *trackView = [[KFFlyCommentTrackView alloc]initWithFrame:CGRectMake(0, (self.trackHeight + self.trackVerticalMargin) * i, self.frame.size.width, self.trackHeight)];
        trackView.trackHeight = self.trackHeight;
        trackView.trackHorizontalPadding = self.trackHorizontalPadding;
        trackView.infinityLoop = self.infinityLoop;
        [self addSubview:trackView];
        [_trackArray addObject:trackView];
        if (_trackSpeedArray.count - 1 == i) {
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(trackView.frame));
        }
    }
}

- (void)start {
    if (_timer) {
        return;
    }
    //开始其实就是开始定时器
    _timer = [NSTimer timerWithTimeInterval:1.0 / COMMENT_VIEW_CONFIG_FPS target:self selector:@selector(startAction) userInfo:nil repeats:YES];
    //加到runloop，防止scrollview影响
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)pause
{
    //暂停其实就是销毁计时器
    [_timer invalidate];
    _timer = nil;
}

- (void)stop
{
    //停止就是销毁计时器
    [_timer invalidate];
    _timer = nil;
    //然后移除所有轨道的弹幕
    for (KFFlyCommentTrackView *trackView in _trackArray)
    {
        [trackView cleanTrack];
    }
}

- (void)destory
{
    [_timer invalidate];
    _timer = nil;
    for (KFFlyCommentTrackView *trackView in _trackArray)
    {
        [trackView cleanTrack];
        [trackView removeFromSuperview];
    }
    [_trackArray removeAllObjects];
    _trackSpeedArray = nil;
    _trackArray = nil;
}

/**
 Timer方法
 */
- (void)startAction
{
    for (int i = 0; i<_trackArray.count; i++)
    {
        //其实就是遍历所有轨道执行轨道定时器的方法
        KFFlyCommentTrackView *trackView = _trackArray[i];
        [trackView moveFlyCommentViewWithSpeed:[_trackSpeedArray[i] floatValue]];
    }
}

/**
 插入一条弹幕，可以插入任意继承UIView的对象
 
 @param customView 自定义的view（注意，最高不能超过轨道的高，否则会出问题。轨道的高度请在FlyCommentViewConfig.h中配置）
 @param trackIndex 插入弹幕的轨道（为-1则代表自动寻找最不拥挤的轨道插入）
 */
- (void)appendFlyCommentWithCustomView:(UIView *)customView toTrackIndex:(NSInteger)trackIndex
{
    NSInteger realTrackIndex = trackIndex;
    if (realTrackIndex == -1)
    {
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
- (int)findTheMinTotalWidthTrack
{
    KFFlyCommentTrackView *firstTrackView = _trackArray[0];
    int minWidthIndex = 0;
    float minWidth = [firstTrackView rightOutScreenWidth];
    for (int i = 0; i<_trackArray.count; i++)
    {
        KFFlyCommentTrackView *trackView = _trackArray[i];
        float trackRightOutScreenWidth = [trackView rightOutScreenWidth];
        if (trackRightOutScreenWidth < minWidth)
        {
            minWidth = trackRightOutScreenWidth;
            minWidthIndex = i;
        }
        
    }
    return minWidthIndex;
}

@end
