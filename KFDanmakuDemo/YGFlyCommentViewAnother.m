//
//  YGFlyCommentViewAnother.m
//  YGFlyCommentDemo
//
//  Created by zhangkaifeng on 2017/5/10.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "YGFlyCommentViewAnother.h"

@implementation YGFlyCommentViewAnother

- (instancetype)initWithMessageModel:(YGFlyCommentModel *)messageModel height:(float)height
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 0, 25);
        _messageModel = messageModel;
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.layer.cornerRadius = 5;
    
    
    //头像
    UIImageView *avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(3, 3, self.frame.size.height  - 6, self.frame.size.height  - 6)];
    avatarImageView.layer.cornerRadius = self.frame.size.height  - 6/2;
    avatarImageView.clipsToBounds = YES;
    avatarImageView.image = [UIImage imageNamed:_messageModel.userAvatar];
    [self addSubview:avatarImageView];
    
    //名
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = [NSString stringWithFormat:@"%@:%@",_messageModel.userName,_messageModel.msg];
    [nameLabel sizeToFit];
    nameLabel.frame = CGRectMake(CGRectGetMaxX(avatarImageView.frame) + 5, 4, nameLabel.frame.size.width, nameLabel.frame.size.height);
    nameLabel.center = CGPointMake(nameLabel.center.x, avatarImageView.center.y);
    [self addSubview:nameLabel];
    
    
    self.frame = CGRectMake(0, 0, CGRectGetMaxX(nameLabel.frame) + 10, self.frame.size.height);
}

@end
