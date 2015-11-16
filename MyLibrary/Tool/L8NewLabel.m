//
//  L8NewLabel.m
//  网易新闻
//
//  Created by 李亮 on 15/6/21.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8NewLabel.h"

@implementation L8NewLabel


-(void)awakeFromNib
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.preferredMaxLayoutWidth = self.bounds.size.width;
    
    [super layoutSubviews];
}

@end
