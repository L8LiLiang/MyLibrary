//
//  L8FlagView.m
//  选择国旗
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8FlagView.h"

@interface L8FlagView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation L8FlagView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)flagView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"L8FlagView" owner:nil options:nil] firstObject];
}

-(void)setFlag:(L8Flag *)flag
{
    _flag = flag;
    self.label.text = flag.name;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guoqi/%@",flag.icon]];
    //NSString *path = [[NSBundle mainBundle] pathForResource:flag.icon ofType:nil];
    //UIImage *image = [UIImage imageWithContentsOfFile:path];
    //self.imageView.image = image;
    [self.button setBackgroundImage:image forState:UIControlStateNormal];
}

@end
