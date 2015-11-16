//
//  L8LoginModule.h
//  Base64登陆
//
//  Created by 李亮 on 15/6/11.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8LoginModule : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *pwd;

+(instancetype)sharedLoginModule;
-(void)loginWithComepleteBlock:(void(^)(bool success))block;

-(void)testWithBlock:(void(^)())block;

@end
