//
//  YGFlyCommentManager.m
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "YGFlyCommentManager.h"

@implementation YGFlyCommentManager

+ (YGFlyCommentManager *)sharedManager
{
    static YGFlyCommentManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)createFlyCommentViewWithTrackSpeedArray:(NSArray *)trackSpeedArray myCenterY:(float)myCenterY trackWidth:(float)trackWidth shouldAddToView:(UIView *)superView
{
    
    _superView = superView;
    _trackSpeedArray = trackSpeedArray;
    _myCenterY = myCenterY;
    _trackWidth = trackWidth;
    _trackArray = [[NSMutableArray alloc]init];
    
    [self configUI];
}

- (void)configUI
{
    //先建立一个baseview
    _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _trackWidth, 0)];
    _baseView.userInteractionEnabled = NO;
    [_superView addSubview:_baseView];
    
    for (int i = 0; i<_trackSpeedArray.count; i++)
    {
        //把轨道按照间距加到baseview上，再加到数组中
        YGFlyCommentTrackView *trackView = [[YGFlyCommentTrackView alloc]initWithFrame:CGRectMake(0, (TRACK_HEIGHT + TRACK_VERTICAL_PADDING) * i, _baseView.frame.size.width, TRACK_HEIGHT)];
        [_baseView addSubview:trackView];
        [_trackArray addObject:trackView];
        if (_trackSpeedArray.count - 1 == i)
        {
            _baseView.frame = CGRectMake(_baseView.frame.origin.x, _baseView.frame.origin.y, _baseView.frame.size.width, CGRectGetMaxY(trackView.frame));
            _baseView.center = CGPointMake(_baseView.center.x, _myCenterY);
        }
    }
}

- (void)start
{
    if (_timer)
    {
        return;
    }
    //开始其实就是开始定时器
    _timer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(startAction) userInfo:nil repeats:YES];
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
    for (YGFlyCommentTrackView *trackView in _trackArray)
    {
        [trackView cleanTrack];
    }
}

- (void)destory
{
    [_timer invalidate];
    _timer = nil;
    for (YGFlyCommentTrackView *trackView in _trackArray)
    {
        [trackView cleanTrack];
        [trackView removeFromSuperview];
    }
    [_trackArray removeAllObjects];
    [_baseView removeFromSuperview];
    _trackSpeedArray = nil;
    _superView = nil;
    _baseView = nil;
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
        YGFlyCommentTrackView *trackView = _trackArray[i];
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
    
    YGFlyCommentTrackView *trackView = _trackArray[realTrackIndex];
    [trackView appendFlyCommentWithCustomView:customView];
}

/**
 找到最短右侧出屏幕和等待数组总长度最短的轨道序号

 @return 轨道的序号
 */
- (int)findTheMinTotalWidthTrack
{
    YGFlyCommentTrackView *firstTrackView = _trackArray[0];
    int minWidthIndex = 0;
    float minWidth = [firstTrackView rightOutScreenWidth];
    for (int i = 0; i<_trackArray.count; i++)
    {
        YGFlyCommentTrackView *trackView = _trackArray[i];
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
