//
//  NSObject+L8RuntimeExtension.m
//  网易新闻
//
//  Created by 李亮 on 15/6/22.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "NSObject+L8RuntimeExtension.h"
#import <objc/runtime.h>

#define KPROPERTIES

@implementation NSObject (L8RuntimeExtension)

+(instancetype)objWithDict:(NSDictionary *)dict
{
    id new = [[self alloc] init];
    
    for (NSString *key in [self properties]) {
        id value = dict[key];
        if (value) {
            [new setValue:value forKeyPath:key];
        }
    }
    
    return new;
}

+(NSArray *)properties
{
    const char *key = "properties";
    NSArray *associatedObject = objc_getAssociatedObject(self, key);
    if (associatedObject != nil) {
        return associatedObject;
    }
    
    NSMutableArray *arrayM = [NSMutableArray array];
    
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self, &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char* name = property_getName(property);
        NSString *strName = [[NSString alloc] initWithUTF8String:name];
        [arrayM addObject:strName];
    }
    
    free(properties);
    
    objc_setAssociatedObject(self, key, arrayM.copy, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return objc_getAssociatedObject(self, key);
}


@end
