//
//  GoViewController.m
//  YGFlyCommentDemo
//
//  Created by zhangkaifeng on 2017/5/10.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "GoViewController.h"
#import "KFFlyCommentView.h"
#import "CustomView.h"
#import "YGFlyCommentModel.h"
#import "KFFlyCommentView.h"
#import "YGFlyCommentViewAnother.h"

@interface GoViewController ()

@property (nonatomic, strong) KFFlyCommentView *commentView;

@end

@implementation GoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.commentView = [[KFFlyCommentView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0) trackVerticalMargin:10 trackHeight:100 trackSpeedArray:self.speedArray];
    [self.view addSubview:self.commentView];
//    self.commentView.infinityLoop = YES;
//    self.commentView.joinWithLeftEdge = YES;
//    self.commentView.dragEnable = YES;
    [self.commentView start];
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
        [self.commentView start];
    }
    else
    {
        [self.commentView pause];
    }
}

- (IBAction)insertFlyComment:(id)sender
{
    NSArray *classArray = @[@"CustomView",@"YGFlyCommentViewAnother"];
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
    
    
    CustomView *customView = [[NSClassFromString(classArray[classRandomIndex]) alloc]initWithMessageModel: model height:40];
    [self.commentView appendFlyCommentWithCustomView:customView toTrackIndex:-1];
}

- (void)dealloc
{
    [self.commentView destory];
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
