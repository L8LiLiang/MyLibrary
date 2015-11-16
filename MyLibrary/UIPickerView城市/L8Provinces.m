//
//  L8Provinces.m
//  城市选择
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8Provinces.h"

@implementation L8Provinces
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)provincesWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
