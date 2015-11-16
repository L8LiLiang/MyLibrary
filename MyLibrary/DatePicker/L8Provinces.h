//
//  L8Provinces.h
//  城市选择
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8Provinces : NSObject
@property (copy,nonatomic) NSArray *cities;
@property (copy,nonatomic) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provincesWithDict:(NSDictionary *)dict;
@end
