//
//  KFFlyCommentBulletBaseView.h
//  SmartEstateCC
//
//  Created by 张楷枫 on 2020/12/7.
//  Copyright © 2020 pretang. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KFFlyCommentBulletState) {
    KFFlyCommentBulletStateBegan = 0,
    KFFlyCommentBulletStateEnter,
    KFFlyCommentBulletStateEnd,
};

@interface KFFlyCommentBulletBaseView : UIView

@property (nonatomic, assign) KFFlyCommentBulletState state;
@property (nonatomic, assign) CGFloat speedPerSecond;
@property (nonatomic, assign) BOOL aDealloc;
/**
 横向间距
 */
@property (nonatomic, assign) CGFloat trackHorizontalPadding;
- (void)startWithStateChangedBlock:(void (^)(KFFlyCommentBulletState state))success;

@end
