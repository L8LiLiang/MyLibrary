//
//  OrderProcessFlowNodeView.h
//  tcb
//
//  Created by Chuanxun on 15/11/17.
//  Copyright © 2015年 Jax. All rights reserved.
//

#import <UIKit/UIKit.h>


#define K_NODEVIEW_LABEL1 @"nodeview_label1"
#define K_NODEVIEW_LABEL2 @"nodeview_label2"
#define K_NODEVIEW_ICON @"nodeview_icon"

@interface OrderProcessFlowNodeView : UIView

@property (strong, nonatomic) NSArray *contents;


//*  [{K_NODEVIEW_LABEL1:label1,K_NODEVIEW_LABEL2:label2,K_NODEVIEW_ICON:nil}]  */
+ (instancetype)nodeViewWithArray:(NSArray *)array;

-(CGFloat)estimatedHeightWithWidth:(CGFloat)width;
@end
