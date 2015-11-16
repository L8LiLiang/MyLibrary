//
//  L8Flag.h
//  选择国旗
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8Flag : NSObject
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *icon;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) flagWithDict:(NSDictionary *)dict;
@end
