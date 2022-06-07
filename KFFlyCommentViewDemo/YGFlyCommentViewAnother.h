//
//  YGFlyCommentViewAnother.h
//  YGFlyCommentDemo
//
//  Created by zhangkaifeng on 2017/5/10.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGFlyCommentModel.h"
#import "FlyCommentViewConfig.h"

/**
 这个类是自定义某一条弹幕的view
 */
@interface YGFlyCommentViewAnother : UIView

/**
 弹幕的model
 */
@property (nonatomic,strong) YGFlyCommentModel *messageModel;

/**
 初始化方法
 
 @param messageModel 消息的model
 @return 自己
 */
- (instancetype)initWithMessageModel:(YGFlyCommentModel *)messageModel height:(float)height;

@end
