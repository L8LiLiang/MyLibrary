//
//  UIImage+L8Ext.h
//  彩票
//
//  Created by 李亮 on 15/5/22.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (L8Ext)
+(instancetype)originalImageWithName:(NSString *)name;

/**
 *  根据图片名自动加载适配iOS6\7\8的图片
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  根据图片名返回一张能够自由拉伸的图片
 */
+ (UIImage *)resizedImage:(NSString *)name;

/**
 *  根据RGB颜色值，返回一张图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;
/**
 *  tabBar加载最原始的图片不要渲染
 */
+ (instancetype)imageWithOriginalName:(NSString *)imageName;
/**
 *  可拉伸不变形的图片
 */
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
@end
