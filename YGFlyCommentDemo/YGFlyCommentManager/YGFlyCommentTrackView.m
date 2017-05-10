//
//  YGFlyCommentTrackView.m
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "YGFlyCommentTrackView.h"
#import "FlyCommentViewConfig.h"


@implementation YGFlyCommentTrackView

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
}

- (void)appendFlyCommentWithCustomView:(UIView *)view
{
    //先让插入的弹幕的x等于屏幕宽
    view.frame = CGRectMake(self.frame.size.width, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
    view.center = CGPointMake(view.center.x, TRACK_HEIGHT/2);
    if (_showingArray.count)
    {
        //取出最后一条正在显示的弹幕，也就是最右边的弹幕
        UIView *lastView = [_showingArray lastObject];
        
        //判断如果最右侧的那条弹幕还没有完全出现在屏幕中
        if (CGRectGetMaxX(lastView.frame) + TRACK_HORIZONTAL_PADDING > self.frame.size.width || _waitShowArray.count)
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
        if ((CGRectGetMaxX(firstView.frame) < 0))
        {
            //remove掉节省内存
            [firstView removeFromSuperview];
            [_showingArray removeObjectAtIndex:0];
        }
        //如果等待数组中有值
        if (_waitShowArray.count)
        {
            //如果最右侧的view已经完全出现在屏幕中了
            if (CGRectGetMaxX(lastView.frame) + TRACK_HORIZONTAL_PADDING <= self.frame.size.width)
            {
                //从等待数组中拿出来加入到展示数组
                [_showingArray addObject:[_waitShowArray firstObject]];
                [_waitShowArray removeObjectAtIndex:0];
                //加到屏幕中
                [self addSubview:[_showingArray lastObject]];
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
            outScreenWidth += view.frame.size.width + TRACK_HORIZONTAL_PADDING;
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
