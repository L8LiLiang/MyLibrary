//
//  OrderProcessFlowView.h
//  tcb
//
//  Created by Chuanxun on 15/11/17.
//  Copyright © 2015年 Jax. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Order : NSObject
@property (strong, nonatomic) NSArray *titles;

@end



@interface OrderProcessFlowView : UIScrollView

@property (strong, nonatomic) Order *order;

+ (instancetype)flowViewWithOrder:(Order *)order;
- (void)printFrame;

@end
