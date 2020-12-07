//
//  ViewController.m
//  YGFlyCommentDemo
//
//  Created by zhangkaifeng on 2017/5/10.
//  Copyright © 2017年 张楷枫. All rights reserved.
//

#import "ViewController.h"
#import "GoViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goButtonClick:(id)sender
{
    NSArray *speedArray = [_textView.text componentsSeparatedByString:@","];
    NSMutableArray *trackSpeedArray = [[NSMutableArray alloc]init];
    for (NSString *speedString in speedArray)
    {
        [trackSpeedArray addObject:[NSNumber numberWithFloat:speedString.floatValue]];
    }
    

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    GoViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"IdReceive"];
    controller.speedArray = trackSpeedArray;
    [self presentViewController:controller animated:YES completion:nil];
    
}

@end
