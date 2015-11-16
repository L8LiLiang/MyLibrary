//
//  ViewController.m
//  城市选择
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"
#import "L8Provinces.h"

@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic) NSArray *provinces;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (assign,nonatomic) NSUInteger curIndex;
@end

@implementation ViewController

-(NSArray *)provinces
{
    if (!_provinces) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
        NSArray *arrayFromPlist = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayTmp = [NSMutableArray array];
        for (NSDictionary *dict in arrayFromPlist) {
            L8Provinces *province = [L8Provinces provincesWithDict:dict];
            [arrayTmp addObject:province];
        }
        _provinces = arrayTmp;
    }
    return _provinces;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.provinces count];
    }else
    {
        NSUInteger curIndex = [pickerView selectedRowInComponent:0];
        return [[self.provinces[curIndex] cities] count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.provinces[row] name];
    }else
    {
        //NSUInteger curIndex = [pickerView selectedRowInComponent:0];
        return [self.provinces[self.curIndex] cities][row];
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        [pickerView reloadComponent:1];
        self.curIndex = row;
    }
}
@end
