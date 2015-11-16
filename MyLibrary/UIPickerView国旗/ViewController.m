//
//  ViewController.m
//  选择国旗
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"
#import "L8Flag.h"
#import "L8FlagView.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (strong,nonatomic) NSArray *flags;
@end

@implementation ViewController

-(NSArray*)flags
{
    if (!_flags) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        NSArray *tmpArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in tmpArray) {
            L8Flag *flag = [L8Flag flagWithDict:dict];
            [array addObject:flag];
        }
        _flags = array;
    }
    return _flags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}


#pragma mark - UIPickerDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (view) {
        L8FlagView *flagView = (L8FlagView*)view;
        flagView.flag = self.flags[row];
        return view;
    }
    L8FlagView *flagView = [L8FlagView flagView];
    flagView.flag = self.flags[row];
    return flagView;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

@end
