//
//  L8Flag.m
//  选择国旗
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8Flag.h"

@implementation L8Flag

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)flagWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end
