//
//  ViewController.m
//  JS交互
//
//  Created by 李亮 on 15/6/18.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"demo.html" withExtension:nil];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:request];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%ld",(long)navigationType);
    
    if (![request.URL.scheme isEqualToString:@"itcast"]) {
        return YES;
    }
    
    
    if (request.URL.pathComponents.count != 3) {
        return NO;
    }
    NSString *funName = request.URL.pathComponents[1];
    NSString *param = request.URL.pathComponents[2];
    
    SEL func = NSSelectorFromString(funName);
    
    if (![self respondsToSelector:func]) {
        return NO;
    }
    
    /**
     原因：
     1. 不要忽视任何警告
     2. 开发好的框架，需要这个技术
     */
    // 让 clang 编译器警告压栈
#pragma clang diagnostic push
    // 让 clang 忽略 performSelector-leaks 错误
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:func withObject:param];
    // 让 clang 编译器警告出栈，恢复之前的状态
#pragma clang diagnostic pop

    return NO;
}

-(void)showMessage:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"ALERT" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //NSLog(@"%@",textField.text);
        textField.text = @"hello richard.stevens!";
    }];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"%@",action.title);
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [webView stringByEvaluatingJavaScriptFromString:@"clickme()"];
}

@end
