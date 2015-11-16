//
//  AccesseryView.m
//  DatePicker
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "AccesseryView.h"

@interface AccesseryView ()


@end

@implementation AccesseryView

+(instancetype)accessoryView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"AccesseryView" owner:nil options:nil] firstObject];
}

- (IBAction)previousClick:(UIBarButtonItem *)sender {
    if ([self.myDelegate respondsToSelector:@selector(accesseryView:buttonClickForType:)]) {
        if (sender == self.previous) {
            [self.myDelegate accesseryView:self buttonClickForType:AccesseryViewButtonTypePrevious];
        }else if(sender == self.next)
        {
            [self.myDelegate accesseryView:self buttonClickForType:AccesseryViewButtonTypeNext];
   
        }else
        {
            [self.myDelegate accesseryView:self buttonClickForType:AccesseryViewButtonTypeDone];
 
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
