# YGFlyCommentManager-Danmaku

一个可以随意自定义view的弹幕类/A danmaku class that can customize view as your pleases

## 效果

[点击查看效果图](https://s3.ax1x.com/2020/12/07/Dvq8ET.gif)

## 特性
- [x] 支持完全自定义弹幕
- [x] 支持弹幕的回收
- [x] 支持弹幕速度调整
- [x] 支持自定义弹幕轨道数量
- [x] 支持自定义弹幕间距
- [x] 支持自定义弹幕轨道间距
- [x] 支持不同弹幕样式使用相同/不同轨道
- [x] 支持自动寻找最不拥挤的弹幕轨道

## 用法

##### Demo

`YourClass`

```objc
/**
 创建轨道

 @param frame frame
 @param trackHorizontalPadding 横向间距
 @param trackVerticalPadding 轨道纵向间距
 @param trackHeight 轨道高
 @param trackSpeedArray 轨道速度数组
 */
 _danmakuView = [[KFFlyCommentView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height) 
                                 trackHorizontalPadding:10 
                                   trackVerticalPadding:10 
                                            trackHeight:40 
                                        trackSpeedArray:_speedArray];
 [self.view addSubview:_danmakuView];

/**
 插入一条弹幕，可以插入任意继承UIView的对象

 @param customView 自定义的继承于view（注意，最高不能超过轨道的高，否则会出问题。
轨道的高度请在FlyCommentViewConfig.h中配置）
 @param trackIndex 插入弹幕的轨道（为-1则代表自动寻找最不拥挤的轨道插入）
 */
 [_danmakuView appendFlyCommentWithCustomView:customView toTrackIndex:-1];
```
##### 创建弹幕
 ```objc
 - (instancetype)initWithFrame:(CGRect)frame
        trackHorizontalPadding:(CGFloat)trackHorizontalPadding
          trackVerticalPadding:(CGFloat)trackVerticalPadding
                   trackHeight:(CGFloat)trackHeight
               trackSpeedArray:(NSArray *)trackSpeedArray;
 ```
 
 ##### 插入一条弹幕
 ```objc
 - (void)appendFlyCommentWithCustomView:(UIView *)customView toTrackIndex:(NSInteger)trackIndex;
 ```
 
 ##### 停止播放弹幕（会清空所有弹幕）
 ```objc
 - (void)stop;
 ```
 
## 联系我
- 邮箱: 651146554@qq.com
- QQ：651146554
