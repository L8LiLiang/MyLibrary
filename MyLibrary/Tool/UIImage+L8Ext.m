//
//  UIImage+L8Ext.m
//  彩票
//
//  Created by 李亮 on 15/5/22.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "UIImage+L8Ext.h"

@implementation UIImage (L8Ext)
+(instancetype)originalImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
