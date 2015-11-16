//
//  AccesseryView.h
//  DatePicker
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AccesseryView;

typedef enum {
    AccesseryViewButtonTypePrevious,
    AccesseryViewButtonTypeNext,
    AccesseryViewButtonTypeDone
}AccesseryViewButtonType;

@protocol AccesseryViewDelegate <NSObject>


- (void)accesseryView:(AccesseryView*)accessserView buttonClickForType:(AccesseryViewButtonType)type;

@end

@interface AccesseryView : UIToolbar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previous;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *next;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *done;

@property (weak,nonatomic) id<AccesseryViewDelegate> myDelegate;
+ (instancetype)accessoryView;
@end
