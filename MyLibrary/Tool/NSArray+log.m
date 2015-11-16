//
//  NSArray+log.m
//  NSURLRequest
//
//  Created by 李亮 on 15/6/8.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "NSArray+log.h"

@implementation NSArray (log)

-(NSString *)descriptionForDebug
{
    NSMutableString *des = [[NSMutableString alloc] init];
    
    [des appendString:@"(\r\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [des appendFormat:@"%@,\r\n",obj];
    }];
    
    [des deleteCharactersInRange:[des rangeOfString:@",\r\n" options:NSBackwardsSearch]];
    
    [des appendString:@"\r\n)"];
    
    return des.copy;
}

-(NSString *)description
{
    NSMutableString *des = [[NSMutableString alloc] init];
    
    [des appendString:@"(\r\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [des appendFormat:@"%@,\r\n",obj];
    }];
    
    [des deleteCharactersInRange:[des rangeOfString:@",\r\n" options:NSBackwardsSearch]];
    
    [des appendString:@"\r\n)"];
    
    return des.copy;
}

//此方法优先
-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *des = [[NSMutableString alloc] init];
    
    [des appendString:@"(\r\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [des appendFormat:@"%@,\r\n",obj];
    }];
    
    [des deleteCharactersInRange:[des rangeOfString:@",\r\n" options:NSBackwardsSearch]];
    
    [des appendString:@"\r\n)"];
    
    return des.copy;
}

@end

@implementation NSDictionary (log)

-(NSString *)descriptionForDebug
{
    NSMutableString *des = [[NSMutableString alloc] init];
    
    [des appendString:@"{\r\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [des appendFormat:@"%@:%@,\r\n",key,obj];
    }];
    
    [des deleteCharactersInRange:[des rangeOfString:@",\r\n" options:NSBackwardsSearch]];
    
    [des appendString:@"\r\n}"];
    
    return des.copy;
}

-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *des = [[NSMutableString alloc] init];
    
    [des appendString:@"{\r\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [des appendFormat:@"%@:%@,\r\n",key,obj];
    }];
    
    [des deleteCharactersInRange:[des rangeOfString:@",\r\n" options:NSBackwardsSearch]];
    
    [des appendString:@"\r\n}"];
    
    return des.copy;
}


@end
