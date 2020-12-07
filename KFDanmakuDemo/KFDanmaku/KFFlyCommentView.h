//
//  KFFlyCommentView.h
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFFlyCommentTrackView.h"

/**
 这个类是管理类，一般调用这个类来管理轨道和弹幕
 */
@interface KFFlyCommentView : UIView


/**
 创建轨道

 @param frame frame
 @param trackHorizontalPadding 横向间距
 @param trackVerticalPadding 轨道纵向间距
 @param trackHeight 轨道高
 @param trackSpeedArray 轨道速度数组
 */
- (instancetype)initWithFrame:(CGRect)frame
       trackHorizontalPadding:(CGFloat)trackHorizontalPadding
         trackVerticalPadding:(CGFloat)trackVerticalPadding
                  trackHeight:(CGFloat)trackHeight
              trackSpeedArray:(NSArray *)trackSpeedArray;

/**
 插入一条弹幕，可以插入任意继承UIView的对象

 @param customView 自定义继承于KFFlyCommentBulletBaseView的view（注意，最高不能超过轨道的高，否则会出问题。轨道的高度请在FlyCommentViewConfig.h中配置）
 @param trackIndex 插入弹幕的轨道（为-1则代表自动寻找最不拥挤的轨道插入）
 */
- (void)appendFlyCommentWithCustomView:(KFFlyCommentBulletBaseView *)customView toTrackIndex:(NSInteger)trackIndex;


/**
 停止播放弹幕（会清空所有弹幕）
 */
- (void)stop;


@end
