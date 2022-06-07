//
//  CustomView.m
//  ParadiseWordLive
//
//  Created by zhangkaifeng on 2017/5/8.
//  Copyright © 2017年 . All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithMessageModel:(YGFlyCommentModel *)messageModel height:(float)height
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, 0, height);
        _messageModel = messageModel;
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.layer.cornerRadius = self.frame.size.height/2;
    
    
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
    nameLabel.text = _messageModel.userName;
    [nameLabel sizeToFit];
    nameLabel.frame = CGRectMake(CGRectGetMaxX(avatarImageView.frame) + 5, 4, nameLabel.frame.size.width, nameLabel.frame.size.height);
    [self addSubview:nameLabel];
    
    //文字
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.font = [UIFont systemFontOfSize:13];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = _messageModel.msg;
    [messageLabel sizeToFit];
    messageLabel.frame = CGRectMake(nameLabel.frame.origin.x, CGRectGetMaxY(avatarImageView.frame) - messageLabel.frame.size.height - nameLabel.frame.origin.y, messageLabel.frame.size.width, messageLabel.frame.size.height);
    [self addSubview:messageLabel];
    
    float width = messageLabel.frame.size.width > nameLabel.frame.size.width ? messageLabel.frame.size.width:nameLabel.frame.size.width;
    
    self.frame = CGRectMake(0, 0, nameLabel.frame.origin.x + 10 + width, self.frame.size.height);
    
    UIButton *testButton = [[UIButton alloc] initWithFrame:self.frame];
    [testButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:testButton];
}

- (void)test {
    NSLog(@"test");
}


@end
