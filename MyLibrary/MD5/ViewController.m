//
//  ViewController.m
//  Base64登陆
//
//  Created by 李亮 on 15/6/10.
//  Copyright (c) 2015年 李亮. All rights reserved.
//


#import "ViewController.h"
#import "L8LoginModule.h"
#import "MainControllerViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation ViewController

- (IBAction)login:(id)sender {
    L8LoginModule *login = [L8LoginModule sharedLoginModule];
    [login loginWithComepleteBlock:^(bool success) {
        if (success) {
            
            NSString *sbName = @"Main";
            UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
            MainControllerViewController *vc = [sb instantiateInitialViewController];
            
            [UIApplication sharedApplication].keyWindow.rootViewController = vc;
        }
    }];
}


-(void)dealloc
{
    NSLog(@"ViewController dealloced");
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
}


@end
