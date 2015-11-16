//
//  Base64.m
//  MyLibrary
//
//  Created by 李亮 on 15/11/16.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "Base64.h"

@implementation Base64

@end


#define KUSER @"name"
#define KPWD @"pwd"


#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation ViewController
- (IBAction)login:(id)sender {
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    
    
    NSString *name = self.name.text;
    NSString *pwd = self.pwd.text;
    name = [self encodeToPercentEscapeString:name];
    pwd = [self encodeBase64:pwd];
    NSLog(@"%@",pwd);
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",name,pwd];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError && data) {
            id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",dict);
            [self saveUserInfo];
        }else
        {
            NSLog(@"%@",connectionError);
        }
    }];
    
}

-(void)saveUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.name.text forKey:KUSER];
    [userDefault setObject:self.pwd.text forKey:KPWD];
    [userDefault synchronize];
}

-(void)loadUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.name.text = [userDefault objectForKey:KUSER];
    self.pwd.text = [userDefault objectForKey:KPWD];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadUserInfo];
}

//对url特殊符号进行编码
- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http: www.ietf.org="" rfc="" rfc3986.txt="">)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

//url解码
- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    return [input stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//base64 编码 "加密" 密码     可以把任意的二进制数据 转换成字符串
- (NSString *)encodeBase64:(NSString *)input{
    //不管是编码 还是加密  都是对二进制数据进行 操作
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

//base64 解码 "解密"
- (NSString *)decodeBase64:(NSString *)input{
    //解码
    NSData *data = [[NSData alloc] initWithBase64EncodedString:input options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
