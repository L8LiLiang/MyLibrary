//
//  HitTest.m
//  MyLibrary
//
//  Created by 李亮 on 15/11/16.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "HitTest.h"
#import <UIKit/UIKit.h>
@implementation HitTest

/*
 
 hit－testing：
 在视图结构中，从上到下，递归调用 hitTest:withEvent: 方法， hitTest:withEvent: 方法中，通过调用自己的 pointInside:withEvent: 方法，确定点击位置是否在自己的bounds中，如果是， pointInside:withEvent: 返回YES，否则返回NO。
 如果 pointInside:withEvent: 返回YES了，那么会递归调用自己子视图的hitTest:withEvent: 方法，子视图使用同样的方法进行判断。最后hitTest:withEvent: 方法方法会返回用户所直接点击的控件。
 hitTest:withEvent: 方法跳过以下控件：被隐藏的、禁止用户交互的、透明度小于0.01的。如果父控件属于这种情况，那么子控件肯定也不会收到事件消息了。
 另外，如果一个子视图的显示范围超出父视图，那么在父视图范围外的点击事件，子视图永远获取不到，这种情况可能会发生在父视图的clipsToBunds设置为NO的情况下。
*/

/*
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint pointInSubview = [self convertPoint:point toView:self.viewB];
    UIView *result = [self.viewB hitTest:pointInSubview withEvent:event];
    if (result) {
        return result;
    }
    return [super hitTest:point withEvent:event];
}
 */

@end
