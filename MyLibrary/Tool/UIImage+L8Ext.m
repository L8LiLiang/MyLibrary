//
//  UIImage+L8Ext.m
//  彩票
//
//  Created by 李亮 on 15/5/22.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "UIImage+L8Ext.h"

// 适配当前设备系统iOS7、iOS8、当前屏幕的宽高、当前app版本、当前窗口、当前设备
#define iOS9         ([[UIDevice currentDevice].systemVersion doubleValue] >= 9.0f)
#define iOS8         ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0f && [[UIDevice currentDevice].systemVersion doubleValue] < 9.0f)
#define iOS7         ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0f && [[UIDevice currentDevice].systemVersion doubleValue] < 8.0f)
#define SCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define AppVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define iPhone4      (SCREEN_HEIGHT == 480.f)
#define iPhone5      (SCREEN_HEIGHT == 568.f)
#define iPhone6      (SCREEN_HEIGHT == 667.f)
#define iPhone6plus  (SCREEN_HEIGHT == 736.f)

// 调试状态, 打开LOG功能
#ifdef DEBUG
#define TCBLog(...) NSLog(__VA_ARGS__)
#else
// 发布状态, 关闭LOG功能
#define TCBLog(...)
#endif


@implementation UIImage (L8Ext)
+(instancetype)originalImageWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *)imageWithName:(NSString *)name {
    UIImage *image = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {//处理iOS8的图片
        NSString *newName = [name stringByAppendingString:@"_os8"];
        image = [UIImage imageNamed:newName];
    }else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){//处理iOS7的图片
        NSString *newName = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {//处理iOS6以及之前的图片
        image = [UIImage imageNamed:name];
    }
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name
{
    //设置图片的如何拉伸,定好四个边的内边距,只拉伸里面的外面保持原状（实际是外边不变 内部来个平铺图片）
    UIImage *image = [UIImage imageNamed:name];
    CGFloat w = image.size.width * 0.5;
    CGFloat h = image.size.height * 0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w) resizingMode:UIImageResizingModeStretch];
}

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


@end
