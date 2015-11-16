//
//  L8LoginModule.m
//  Base64登陆
//
//  Created by 李亮 on 15/6/11.
//  Copyright (c) 2015年 李亮. All rights reserved.
//


#define KUSER @"name"
#define KPWD @"pwd"
#define KSERVICE [NSBundle mainBundle].bundleIdentifier

#import "L8LoginModule.h"
#import "NSString+Hash.h"
#import "SSKeychain.h"
#import "L8Encode.h"

@implementation L8LoginModule

-(void)testWithBlock:(void (^)())block
{
    sleep(2);
    if (block) {
        block();
    }
}

+(instancetype)sharedLoginModule
{
    static L8LoginModule *sharedLoginModule;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLoginModule = [[self alloc] init];
    });
    return sharedLoginModule;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self loadUserInfo];
    }
    return self;
}

-(void)loginWithComepleteBlock:(void(^)(bool success))block
{
    NSLog(@"loginWithComepleteBlock %@",[NSThread currentThread]);
    
    if (!self.name || !self.pwd) {
        if (block) {
            block(false);
        }
        return;
    }
    
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/loginhmac.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    
    
    NSString *name = self.name;
    NSString *pwd = self.pwd;
    
    name = [L8Encode encodeToPercentEscapeString:name];
    //md5
    //    pwd = [pwd md5String];
    
    //hmac
    //    pwd = [pwd hmacMD5StringWithKey:@"dfsdfsd"];
    
    //hmac+time
    
    pwd = [self getMd5String];
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@",name,pwd];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError && data) {
            id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"%@",dict);
            if (![dict[@"userName"] isEqualToString:@""]) {
                [self saveUserInfo];
                if (block) {
                    NSLog(@"loginWithComepleteBlock finish%@",[NSThread currentThread]);

                    block(true);
                }
            }else
            {
                if (block) {
                    block(false);
                }
            }

        }else
        {
            //NSLog(@"%@",connectionError);
            if (block) {
                block(false);
            }            
        }
    }];
    

}

-(NSString *)getMd5String
{
    NSString *keyString = @"21#@$!";
    keyString = [keyString md5String];
    NSLog(@"%@",keyString);
    
    NSString *pwd = self.pwd;
    pwd = [pwd hmacMD5StringWithKey:keyString];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://127.0.0.1/hmackey.php"]];
    id dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    NSString *time = dic[@"key"];
    
    pwd = [[NSString stringWithFormat:@"%@%@",pwd,time] hmacMD5StringWithKey:keyString];
    
    return pwd;
}

-(void)saveUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.name forKey:KUSER];
    //[userDefault setObject:self.pwd.text forKey:KPWD];
    [userDefault synchronize];
    
    [SSKeychain setPassword:self.pwd forService:KSERVICE account:self.name];
}

-(void)loadUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.name = [userDefault objectForKey:KUSER];
    //self.pwd.text = [userDefault objectForKey:KPWD];
    self.pwd = [SSKeychain passwordForService:KSERVICE account:self.name];
}


@end
