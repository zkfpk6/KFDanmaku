//
//  YGFlyCommentManager.h
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGFlyCommentTrackView.h"

/**
 这个类是管理类，一般调用这个类来管理轨道和弹幕
 */
@interface YGFlyCommentManager : NSObject

@property (nonatomic,strong) NSArray *trackSpeedArray;
@property (nonatomic,assign) float myCenterY;
@property (nonatomic,assign) float trackWidth;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIView *superView;
@property (nonatomic,strong) NSMutableArray *trackArray;
@property (nonatomic,strong) UIView *baseView;

/**
 单例创建方法

 @return 单例
 */
+ (YGFlyCommentManager *)sharedManager;

/**
 创建轨道

 @param trackSpeedArray 轨道速度数组
 @param myCenterY 所有轨道的中心点
 @param trackWidth 轨道宽
 @param superView 加到哪个view上
 */
- (void)createFlyCommentViewWithTrackSpeedArray:(NSArray *)trackSpeedArray myCenterY:(float)myCenterY trackWidth:(float)trackWidth shouldAddToView:(UIView *)superView;

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


@end
