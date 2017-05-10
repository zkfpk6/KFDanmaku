//
//  YGFlyCommentTrackView.h
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlyCommentViewConfig.h"

/**
 这个类是弹幕轨道的类
 */
@interface YGFlyCommentTrackView : UIView

/**
 等待出现到屏幕中的弹幕view数组
 */
@property (nonatomic,strong) NSMutableArray *waitShowArray;

/**
 正在展示的弹幕view数组
 */
@property (nonatomic,strong) NSMutableArray *showingArray;

/**
 向轨道中插入一条自定义的view

 @param view 自定义的view，高度不可超过轨道的高，否则出问题
 */
- (void)appendFlyCommentWithCustomView:(UIView *)view;

/**
 当前轨道右侧出屏幕的距离+等待出现到屏幕中的弹幕view的总长度和
 @return 等待弹幕+右侧出屏幕弹幕的和
 */
- (float)rightOutScreenWidth;

/**
 清理轨道，移除所有弹幕
 */
- (void)cleanTrack;

/**
 根据速度移动轨道中所有弹幕的位置

 @param speed 每0.01秒弹幕向左移动的距离
 */
- (void)moveFlyCommentViewWithSpeed:(float)speed;

@end
