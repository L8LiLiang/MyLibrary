//
//  ViewController.m
//  MBProgressHUD-Test
//
//  Created by 李亮 on 15/5/14.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

@interface ViewController ()
@property (weak, nonatomic) MBProgressHUD *mbProgressHUD;
@end

@implementation ViewController
- (IBAction)showMBProgressHUD:(UIButton *)sender {

//    MBProgressHUD *mbProgressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
//    mbProgressHUD.mode = MBProgressHUDModeIndeterminate;
//    mbProgressHUD.animationType = MBProgressHUDAnimationZoomIn;
//    mbProgressHUD.dimBackground = YES;
//    self.mbProgressHUD = mbProgressHUD;
//    [self performSelector:@selector(stop) withObject:nil afterDelay:2];
    
    MBProgressHUD *mbProgressHUD = [[MBProgressHUD alloc] initWithView:self.view];
    mbProgressHUD.dimBackground = YES;
    self.mbProgressHUD = mbProgressHUD;
    [self.view addSubview:mbProgressHUD];
    [mbProgressHUD show:YES];
    
//    mbProgressHUD.graceTime = 5;//最多等待多少秒开始显示，如果超时后taskInProgress为NO，就不显示了,用于判断任务是否执行时间太长，如果太长就显示进度条
//    //mbProgressHUD.taskInProgress = YES;
//    [mbProgressHUD showWhileExecuting:@selector(test) onTarget:self withObject:nil animated:YES];
}

- (void) test
{
    while (true) {
        NSLog(@"dddd");
        self.mbProgressHUD.taskInProgress = NO;//如果为NO，就不显示了

    }
}

- (IBAction)stop:(id)sender {
    NSLog(@"stop");
    [self.mbProgressHUD hide:YES];
    
}

- (void)stop
{
    [self.mbProgressHUD hide:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
