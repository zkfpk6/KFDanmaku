//
//  GoViewController.m
//  KFDanmakuDemo
//
//  Created by zhangkaifeng on 2017/5/10.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "GoViewController.h"
<<<<<<< HEAD:KFDanmakuDemo/GoViewController.m
#import "KFDanmaku/KFFlyCommentView.h"
=======
#import "KFFlyCommentView.h"
#import "CustomView.h"
>>>>>>> 新分支:KFFlyCommentViewDemo/GoViewController.m
#import "YGFlyCommentModel.h"
#import "KFFlyCommentView.h"
#import "YGFlyCommentViewAnother.h"

@interface GoViewController ()

<<<<<<< HEAD:KFDanmakuDemo/GoViewController.m
@property (nonatomic, strong) KFFlyCommentView *danmakuView;
=======
@property (nonatomic, strong) KFFlyCommentView *commentView;
>>>>>>> 新分支:KFFlyCommentViewDemo/GoViewController.m

@end

@implementation GoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
<<<<<<< HEAD:KFDanmakuDemo/GoViewController.m
    _danmakuView = [[KFFlyCommentView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height) trackHorizontalPadding:10 trackVerticalPadding:10 trackHeight:40 trackSpeedArray:_speedArray];
    [self.view addSubview:_danmakuView];
=======
    
    self.commentView = [[KFFlyCommentView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 0) infinityLoop:YES trackVerticalMargin:10 trackHorizontalPadding:10 trackHeight:100 trackSpeedArray:self.speedArray];
    [self.view addSubview:self.commentView];
    [self.commentView start];
>>>>>>> 新分支:KFFlyCommentViewDemo/GoViewController.m
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

<<<<<<< HEAD:KFDanmakuDemo/GoViewController.m
- (void)didMoveToParentViewController:(UIViewController *)parent {
    [super didMoveToParentViewController:parent];
    if (parent) {
        return;
=======
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
>>>>>>> 新分支:KFFlyCommentViewDemo/GoViewController.m
    }
    [_danmakuView stop];
}

- (IBAction)startButtonClick:(UIButton *)sender {
    [_danmakuView stop];
}

<<<<<<< HEAD:KFDanmakuDemo/GoViewController.m
- (IBAction)insertFlyComment:(id)sender {
    NSArray *classArray = @[@"YGFlyCommentView",@"YGFlyCommentViewAnother"];
=======
- (IBAction)insertFlyComment:(id)sender
{
    NSArray *classArray = @[@"CustomView",@"YGFlyCommentViewAnother"];
>>>>>>> 新分支:KFFlyCommentViewDemo/GoViewController.m
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
    
    
<<<<<<< HEAD:KFDanmakuDemo/GoViewController.m
    YGFlyCommentView *customView = [[NSClassFromString(classArray[classRandomIndex]) alloc]initWithMessageModel: model height:40];
    [_danmakuView appendFlyCommentWithCustomView:customView toTrackIndex:-1];
=======
    CustomView *customView = [[NSClassFromString(classArray[classRandomIndex]) alloc]initWithMessageModel: model height:40];
    [self.commentView appendFlyCommentWithCustomView:customView toTrackIndex:-1];
}

- (void)dealloc
{
    [self.commentView destory];
>>>>>>> 新分支:KFFlyCommentViewDemo/GoViewController.m
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
