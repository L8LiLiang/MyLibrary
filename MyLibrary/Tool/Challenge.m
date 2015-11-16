//
//  Challenge.m
//  MyLibrary
//
//  Created by 李亮 on 15/11/16.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "Challenge.h"

@implementation Challenge

@end

//
//  ViewController.m
//  challenge
//
//  Created by 李亮 on 15/6/25.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDataDelegate>
@property (strong, nonatomic) NSURLSession *session;
@end

@implementation ViewController

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self upload];
}

-(NSURLSession *)session
{
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    return _session;
}

-(void)upload
{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/uploads/test.png"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"PUT";
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:@"001.png" withExtension:nil];
    [[[self session] uploadTaskWithRequest:request fromFile:fileUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //if (!error) {
        NSLog(@"%@",response);
        //}
    }] resume];
}


-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSLog(@"%@",challenge.protectionSpace);
    
    NSURLCredential *credential = challenge.proposedCredential;
    if (!credential) {
        NSLog(@"create credential");
        credential = [NSURLCredential credentialWithUser:@"admin" password:@"adminqwe" persistence:NSURLCredentialPersistencePermanent];
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }else
    {
        NSLog(@"use exist credential,%@",credential.password);
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling,nil);
    }
    
}

/*
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    NSLog(@"%@",challenge.protectionSpace);
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
    }
}
*/

@end
