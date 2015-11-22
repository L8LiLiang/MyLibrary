//
//  OrderProcessFlowInputBoxNoView.m
//  tcb
//
//  Created by Chuanxun on 15/11/20.
//  Copyright © 2015年 Jax. All rights reserved.
//

#import "OrderProcessFlowInputBoxNoView.h"


#define BOX_NO_VIEW_HEIGHT 50
#define BOX_NO_VIEW_ICON_WIDTH 40
#define BOX_NO_VIEW_TEXTFIELD_HEIGHT 40

@interface OrderProcessFlowInputBoxNoView ()

@property (weak, nonatomic) UIImageView *background;
@property (weak, nonatomic) UIImageView *icon;
@property (weak, nonatomic) UITextField *textField;

@end

@implementation OrderProcessFlowInputBoxNoView

+(instancetype)boxNoView
{
    OrderProcessFlowInputBoxNoView *view = [OrderProcessFlowInputBoxNoView new];
//    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *background = [[UIImageView alloc] init];
    background.image = [UIImage imageNamed:@"signIn_btn_back_green"];
    view.background = background;
    [view addSubview:background];
    
//    [background makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(view);
//    }];
    
    
    
    UIImageView *iconView = [[UIImageView alloc] init];
    UIImage *iconImage = [UIImage imageNamed:@"ic_date_blue"];
    iconView.image = iconImage;
    view.icon =iconView;
    [view addSubview:iconView];
    
    UITextField *textField = [UITextField new];
    NSString *tip = NSLocalizedString(@"click to input box no", @"点击录入封柜号");
    textField.placeholder = tip;
    textField.font = FONT_MIDDLE;
    view.textField = textField;
    [view addSubview:textField];
    
//    [iconView makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(view.centerY);
//        make.size.equalTo(CGSizeMake(BOX_NO_VIEW_ICON_WIDTH, BOX_NO_VIEW_ICON_WIDTH));
//        make.left.equalTo(view.left).offset(16);
//    }];
    
//    [textField makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(view);
//        make.left.equalTo(iconView.right).offset(16);
//        make.right.equalTo(view).offset(-8);
//    }];
    
    return view;
}

-(CGFloat)estimatedHeightWithWidth:(CGFloat)width
{
    return BOX_NO_VIEW_HEIGHT;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.background.frame = self.bounds;
    
    CGFloat iconX,iconY,iconW,iconH;
    iconX = 16;
    iconY = (BOX_NO_VIEW_HEIGHT - BOX_NO_VIEW_ICON_WIDTH)/2.0;
    iconW = BOX_NO_VIEW_ICON_WIDTH;
    iconH = BOX_NO_VIEW_ICON_WIDTH;
    self.icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat textFieldX,textFieldY,textFieldW,textFieldH;
    textFieldX = iconX + BOX_NO_VIEW_ICON_WIDTH;
    textFieldY = (BOX_NO_VIEW_HEIGHT - BOX_NO_VIEW_TEXTFIELD_HEIGHT)/2.0;
    textFieldW = self.frame.size.width - textFieldX - 8;
    textFieldH = BOX_NO_VIEW_TEXTFIELD_HEIGHT;
    self.textField.frame = CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
}

@end
