//
//  GoViewController.m
//  YGFlyCommentDemo
//
//  Created by zhangkaifeng on 2017/5/10.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "GoViewController.h"
#import "YGFlyCommentManager.h"
#import "YGFlyCommentModel.h"
#import "YGFlyCommentView.h"
#import "YGFlyCommentViewAnother.h"

@interface GoViewController ()

@end

@implementation GoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[YGFlyCommentManager sharedManager] createFlyCommentViewWithTrackSpeedArray:_speedArray myCenterY:self.view.frame.size.height/2 trackWidth:self.view.frame.size.width shouldAddToView:self.view];
    [[YGFlyCommentManager sharedManager] start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonClick:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected)
    {
        [[YGFlyCommentManager sharedManager] start];
    }
    else
    {
        [[YGFlyCommentManager sharedManager] pause];
    }
}

- (IBAction)insertFlyComment:(id)sender
{
    NSArray *classArray = @[@"YGFlyCommentView",@"YGFlyCommentViewAnother"];
    NSArray *nameArray = @[@"mc子龙",@"小明",@"赵四",@"狂小狗",@"葬爱"];
    NSArray *msgArray = @[@"老铁666",@"主播，多少礼物给卡黄啊？",@"文明观球，大家有秩序排队观看，不要着急",@"色青主播，我报警啦",@"就是个萨比，还扮滴酷酷滴"];
    NSArray *avatarArray = @[@"home_login_qq_color",@"home_login_wechat_color",@"home_login_weibo_color",@"icon_120-1",@"rank_charm_heart"];
    int classRandomIndex = arc4random() % 2;
    int nameRandomIndex = arc4random() % 5;
    int msgRandomIndex = arc4random() % 5;
    int avatarRandomIndex = arc4random() % 5;
    
    YGFlyCommentModel *model = [[YGFlyCommentModel alloc]init];
    model.userName = nameArray[nameRandomIndex];
    model.msg = msgArray[msgRandomIndex];
    model.userAvatar = avatarArray[avatarRandomIndex];
    
    
    YGFlyCommentView *customView = [[NSClassFromString(classArray[classRandomIndex]) alloc]initWithMessageModel: model height:40];
    [[YGFlyCommentManager sharedManager] appendFlyCommentWithCustomView:customView toTrackIndex:-1];
}

- (void)dealloc
{
    [[YGFlyCommentManager sharedManager] destory];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
