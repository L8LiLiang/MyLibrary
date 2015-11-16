//
//  DrawView.m
//  CGGradient
//
//  Created by 李亮 on 15/5/17.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "DrawView.h"

@implementation DrawView

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] = {1,0,0,1,
        0,1,0,1,
        0,0,1,1};
    
    CGFloat locations[] = {0,0.5,1};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 3);
    
    //CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(300, 300), 0);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(50, 50), 50, CGPointMake(200, 200), 50, 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}
*/

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    // Drawing code
    
    
    [self test4];
}

/*
 
 CGGradientRef CGGradientCreateWithColorComponents ( CGColorSpaceRef space, const CGFloat components[], const CGFloat locations[], size_t count );
 
 //CGColorSpaceRef 代表一个颜色空间
 //components 里面放置N个颜色，根据颜色空间的不同，可能需要不同数量的数字来代表一个颜色
 //locations 0 － 1的N个数字，代表画图区域的N个部分，把N个区域映射到N个颜色，进行渐变
 //count N
 
 void CGContextDrawLinearGradient ( CGContextRef context, CGGradientRef gradient, CGPoint startPoint, CGPoint endPoint, CGGradientDrawingOptions options );
 //context
 //gradient
 //startPoint
 //endPoint 映射颜色时，按照startPoint和endPoint之间的直线，垂直按locations里面的比例划分
 //options
 
 
 CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0);
//此方法相当于定义了一个起始圆，和一个结束圆，起始圆和结束圆中心点之间的连线上面，每一个点都代表一个圆的中心点，所以其实圆盒结束圆之间可以有多个圆，这些圆的线条颜射，根据圆心处于起始圆和结束圆圆心之间的比例位置，映射到location，并且根据location映射到一个颜色，这样就产生渐变，并且可以产生立体效果
 */


- (void)test4
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat location[] = {0,0.25,0.5,1};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[] = {0.0f,0.0f,0.0f,1.0f,
                        0.2f,0.4f,0.8f,1.0f,
                        0.8f,0.4f,0.2f,1.0f,
                        0.3f,0.5f,0.1f,1.0f
                        };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, location, 4);
    CGPoint startPoint = CGPointMake(100, 100);
    CGFloat startRadius = 40;
    CGPoint endPoint = CGPointMake(200, 100);
    CGFloat endRadius = 40;
    CGContextDrawRadialGradient(context, gradient, startPoint, startRadius, endPoint, endRadius, 0);
    
    CFRelease(colorSpace);
    CFRelease(gradient);
}

- (void)test3
{
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    (CGFloat[]){
                                                                        0.01f, 0.99f, 0.01f, 1.0f,
                                                                        0.01f, 0.99f, 0.99f, 1.0f,
                                                                        0.99f, 0.99f, 0.01f, 1.0f
                                                                    },
                                                                    (CGFloat[]){
                                                                        0.1f,
                                                                        0.5f,
                                                                        0.9f
                                                                    },
                                                                    3);
    
    
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    
    // 填充渐变色
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(0.0f, 460.0f), CGPointMake(320.0f, 0.0f),  kCGGradientDrawsBeforeStartLocation);
    
    // 释放渐变对象
    CGGradientRelease(gradientRef);
}

- (void)test2
{
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorSpaceRef,
                                                                    (CGFloat[]){
                                                                        0.01f, 0.99f, 0.01f, 1.0f,
                                                                        0.01f, 0.99f, 0.99f, 1.0f,
                                                                        0.99f, 0.99f, 0.01f, 1.0f
                                                                    },
                                                                    (CGFloat[]){
                                                                        0.0f,
                                                                        0.2f,
                                                                        1.0f
                                                                    },
                                                                    3);
    
    
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    
    // 填充渐变色
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(50.0f, 50.0f), CGPointMake(200, 200), 0);
    
    // 释放渐变对象
    CGGradientRelease(gradientRef);
}

- (void)test1
{
    // 创建Quartz上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 创建色彩空间对象
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    // 创建起点颜色
    CGColorRef beginColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.01f, 0.99f, 0.01f, 1.0f});
    
    // 创建终点颜色
    CGColorRef endColor = CGColorCreate(colorSpaceRef, (CGFloat[]){0.99f, 0.99f, 0.01f, 1.0f});
    
    // 创建颜色数组
    CFArrayRef colorArray = CFArrayCreate(kCFAllocatorDefault, (const void*[]){beginColor, endColor}, 2, nil);
    
    // 创建渐变对象
    CGGradientRef gradientRef = CGGradientCreateWithColors(colorSpaceRef, colorArray, (CGFloat[]){
        0.0f,
        1.0f
    });
    
    // 释放颜色数组
    CFRelease(colorArray);
    
    // 释放起点和终点颜色
    CGColorRelease(beginColor);
    CGColorRelease(endColor);
    
    // 释放色彩空间
    CGColorSpaceRelease(colorSpaceRef);
    
    CGContextDrawLinearGradient(context, gradientRef, CGPointMake(50.0f, 50.0f), CGPointMake(200, 100), 0);
    
    // 释放渐变对象
    CGGradientRelease(gradientRef);

}

@end
