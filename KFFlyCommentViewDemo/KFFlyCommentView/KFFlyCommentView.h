//
//  KFFlyCommentView.h
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KFFlyCommentTrackView.h"

#define COMMENT_VIEW_CONFIG_FPS 60

@interface KFFlyCommentView : UIView


/**
 创建轨道

 @param frame frame
 @param trackHeight 轨道高度
 @param trackSpeedArray 轨道速度数组
 */
- (instancetype)initWithFrame:(CGRect)frame
          trackVerticalMargin:(CGFloat)trackVerticalMargin
                  trackHeight:(CGFloat)trackHeight
              trackSpeedArray:(NSArray *)trackSpeedArray;

/**
 插入一条弹幕，可以插入任意继承UIView的对象

 @param customView 自定义的view（注意，最高不能超过轨道的高，否则会出问题。轨道的高度请在FlyCommentViewConfig.h中配置）
 @param trackIndex 插入弹幕的轨道（为-1则代表自动寻找最不拥挤的轨道插入）
 */
- (void)appendFlyCommentWithCustomView:(UIView *)customView toTrackIndex:(NSInteger)trackIndex;

/**
 开始播放弹幕
 */
- (void)start;

/**
 暂停播放弹幕
 */
- (void)pause;

/**
 停止播放弹幕（会清空所有弹幕）
 */
- (void)stop;

/**
 销毁（不用一定要销毁，防止NSTimer内存泄露）
 */
- (void)destory;

/**
 是否无限滚动 default:NO
 */
@property (nonatomic, assign) BOOL infinityLoop;

/**
 是否从左侧开始 default:NO
 */
@property (nonatomic, assign) BOOL joinWithLeftEdge;

/**
 是否可拖动 default:NO
 */
@property (nonatomic, assign) BOOL dragEnable;

/**
 轨道中内容最小间距 default:10
 */
@property (nonatomic, assign) CGFloat trackHorizontalPadding;

/**
 轨道数组
 */
@property (nonatomic, strong, readonly) NSMutableArray <KFFlyCommentTrackView *>*trackArray;



@end
