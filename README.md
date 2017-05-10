# YGFlyCommentManager-Danmaku

一个可以随意自定义view的弹幕类/A danmaku class that can customize view as your pleases

## 效果

![image](https://github.com/zkfpk6/YGFlyCommentManager-Danmaku/blob/master/Untitled.gif)

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

 @param trackSpeedArray 轨道速度数组
 @param myCenterY 所有轨道的中心点
 @param trackWidth 轨道宽
 @param superView 加到哪个view上
 */
[[YGFlyCommentManager sharedManager] createFlyCommentViewWithTrackSpeedArray:_speedArray 
							myCenterY:self.view.frame.size.height/2 
							trackWidth:self.view.frame.size.width 
							shouldAddToView:self.view];	
/**
 开始播放弹幕
 */
[[YGFlyCommentManager sharedManager] start];			
UILabel *customLabel = [UILabel alloc]init];
customLabel.text = @"这是一条弹幕";
[customLabel sizeToFit];
/**
 插入一条弹幕，可以插入任意继承UIView的对象

 @param customView 自定义的view（注意，最高不能超过轨道的高，否则会出问题。
轨道的高度请在FlyCommentViewConfig.h中配置）
 @param trackIndex 插入弹幕的轨道（为-1则代表自动寻找最不拥挤的轨道插入）
 */
[[YGFlyCommentManager sharedManager] appendFlyCommentWithCustomView:customLabel toTrackIndex:-1];
```
##### 创建弹幕
 ```objc
 - (void)createFlyCommentViewWithTrackSpeedArray:(NSArray *)trackSpeedArray myCenterY:(float)myCenterY trackWidth:(float)trackWidth shouldAddToView:(UIView *)superView;
 ```
 
 ##### 插入一条弹幕
 ```objc
 - (void)appendFlyCommentWithCustomView:(UIView *)customView toTrackIndex:(NSInteger)trackIndex;
 ```
 
 ##### 开始播放弹幕
 ```objc
 - (void)start;
 ```
 
 ##### 暂停播放弹幕
 ```objc
 - (void)pause;
 ```
 
 ##### 停止播放弹幕（会清空所有弹幕）
 ```objc
 - (void)stop;
 ```
 
 ##### 销毁（不用一定要销毁，防止NSTimer内存泄露）
 ```objc
 - (void)destory;
 ```
 
## 联系我
- 邮箱: 651146554@qq.com
- QQ：651146554）
