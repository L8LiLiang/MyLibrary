//
//  L8FlagView.h
//  选择国旗
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "L8Flag.h"

@interface L8FlagView : UIView
@property (strong,nonatomic) L8Flag *flag;
+ (instancetype)flagView;
@end
