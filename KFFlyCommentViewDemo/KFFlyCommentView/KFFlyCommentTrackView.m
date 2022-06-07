//
//  KFFlyCommentTrackView.m
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "KFFlyCommentTrackView.h"

@interface KFFlyCommentTrackView () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation KFFlyCommentTrackView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    _showingArray = [[NSMutableArray alloc]init];
    _waitShowArray = [[NSMutableArray alloc]init];
    
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    _panGestureRecognizer.enabled = NO;
    _panGestureRecognizer.delegate = self;
    [self addGestureRecognizer:_panGestureRecognizer];
}

- (void)setInfinityLoop:(BOOL)infinityLoop {
    _infinityLoop = infinityLoop;
    _panGestureRecognizer.enabled = infinityLoop;
}

- (void)panAction:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:self];
    [panGestureRecognizer setTranslation:CGPointZero inView:self];
    [self moveFlyCommentViewWithSpeed:-translation.x];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 是否为平移手势
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        // 获取平移方向
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
        // 竖向滑动 不响应，防止冲突
        if (translation.y != 0) {
            return NO;
        }
    }
    return YES;
}

- (void)appendFlyCommentWithCustomView:(UIView *)view
{
    //先让插入的弹幕的x等于屏幕宽
    view.frame = CGRectMake(self.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    //纵向居中
    view.center = CGPointMake(view.center.x, self.trackHeight/2);
    if (_showingArray.count)
    {
        //取出最后一条正在显示的弹幕，也就是最右边的弹幕
        UIView *lastView = [_showingArray lastObject];
        
        //判断如果最右侧的那条弹幕还没有完全出现在屏幕中
        if (CGRectGetMaxX(lastView.frame) + self.trackHorizontalPadding > self.frame.size.width || _waitShowArray.count)
        {
            //那就只能先把这条弹幕加到等待数组中
            [_waitShowArray addObject:view];
        }
        //如果最右侧的那条弹幕完全出现在屏幕中
        else
        {
            //加到轨道上
            [self addSubview:view];
            //加到展示数组中
            [_showingArray addObject:view];
        }
    }
    //如果连正在展示的都没有
    else
    {
        //加到轨道上
        [self addSubview:view];
        //加到展示数组中
        [_showingArray addObject:view];
    }
}

- (void)moveFlyCommentViewWithSpeed:(float)speed
{
    if (speed == 0) {
        return;
    }
    BOOL moveToLeft = speed > 0;
    //遍历所有正在展示的弹幕，自减一下
    for (UIView *view in _showingArray)
    {
        view.frame = CGRectMake(view.frame.origin.x - speed, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    }
    
    //如果有正在展示的弹幕
    if (_showingArray.count)
    {
        UIView *firstView = [_showingArray firstObject];
        UIView *lastView = [_showingArray lastObject];
        
        //最左侧的弹幕如果完全运行到了屏幕外
        if ((CGRectGetMaxX(firstView.frame) < 0) && moveToLeft)
        {
            //remove掉节省内存
            [firstView removeFromSuperview];
            [_showingArray removeObjectAtIndex:0];
            //无限循环滚的话 再次加入到等待数组
            if (self.infinityLoop) {
                [self.waitShowArray addObject:firstView];
            }
        }
        // 往右拖，最右侧view消失，x比屏幕宽大
        if (lastView.frame.origin.x > UIScreen.mainScreen.bounds.size.width && !moveToLeft) {
            //remove掉节省内存
            [lastView removeFromSuperview];
            [_showingArray removeLastObject];
            //无限循环滚的话 再次加入到等待数组
            if (self.infinityLoop) {
                [self.waitShowArray insertObject:lastView atIndex:0];
            }
        }
        //如果等待数组中有值
        if (_waitShowArray.count)
        {
            //如果最右侧的view已经完全出现在屏幕中了，或者没有正在显示中的弹幕
            if (((CGRectGetMaxX(lastView.frame) + self.trackHorizontalPadding <= self.frame.size.width) || self.showingArray.count == 0) && moveToLeft)
            {
                //从等待数组中拿出来加入到展示数组
                [_showingArray addObject:[_waitShowArray firstObject]];
                [_waitShowArray removeObjectAtIndex:0];
                UIView *currentView = [_showingArray lastObject];
                //加到屏幕中
                [self addSubview:currentView];
                //重置x坐标
                CGRect frame = currentView.frame;
                frame.origin.x = CGRectGetMaxX(lastView.frame) + self.trackHorizontalPadding;
                currentView.frame = frame;
            }
            
            //如果最左侧的view已经完全出现在屏幕中了，或者没有正在显示中的弹幕
            if (((firstView.frame.origin.x > self.trackHorizontalPadding) || self.showingArray.count == 0) && !moveToLeft)
            {
                //从等待数组中拿出来加入到展示数组
                [_showingArray insertObject:_waitShowArray.lastObject atIndex:0];
                [_waitShowArray removeLastObject];
                UIView *currentView = [_showingArray firstObject];
                //加到屏幕中
                [self addSubview:currentView];
                //重置x坐标
                CGRect frame = currentView.frame;
                frame.origin.x = firstView.frame.origin.x - currentView.frame.size.width - self.trackHorizontalPadding;
                currentView.frame = frame;
            }
        }
    }
}

/**
 这个方法可以拿出所有右侧尚未出现的弹幕和出现在最右侧的那一条弹幕的长度和
 
 @return 长度和
 */
- (float)rightOutScreenWidth
{
    float outScreenWidth = 0.0;
    //如果等待数组中有值
    if (_waitShowArray.count)
    {
        //先遍历所有等待数组中的view，累加长度和间距
        for (UIView *view in _waitShowArray)
        {
            outScreenWidth += view.frame.size.width + self.trackHorizontalPadding;
        }
    }
    
    //如果展示数组中有值
    if (_showingArray.count)
    {
        //拿出最右侧的view
        UIView *lastView = [_showingArray lastObject];
        //算出出屏宽
        float rightOutWidth = CGRectGetMaxX(lastView.frame) - self.frame.size.width;
        if (rightOutWidth < 0)
        {
            rightOutWidth = 0;
        }
        outScreenWidth += rightOutWidth;
    }
    
    return outScreenWidth;
}

//清理轨道
- (void)cleanTrack
{
    for (UIView *view in _showingArray)
    {
        [view removeFromSuperview];
    }
    [_showingArray removeAllObjects];
    [_waitShowArray removeAllObjects];
    
}

@end
