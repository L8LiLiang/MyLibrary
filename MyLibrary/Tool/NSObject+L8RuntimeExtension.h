//
//  NSObject+L8RuntimeExtension.h
//  网易新闻
//
//  Created by 李亮 on 15/6/22.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (L8RuntimeExtension)

+(instancetype)objWithDict:(NSDictionary *)dict;
+(NSArray *)properties;
@end
