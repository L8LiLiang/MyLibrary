//
//  ViewController.m
//  DatePicker
//
//  Created by 李亮 on 15/5/9.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"
#import "AccesseryView.h"
#import "L8Provinces.h"

@interface ViewController () <UITextFieldDelegate,AccesseryViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *birthday;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak,nonatomic) AccesseryView *accessoryView;
@property (strong,nonatomic) NSArray *provinces;
@property (assign,nonatomic) NSUInteger curIndex;
@property (weak,nonatomic) UIPickerView *pickerView;
@end

@implementation ViewController

#pragma mark - UIPickerViewDelegate
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
    //NSUInteger proIndex = [pickerView selectedRowInComponent:0];
    NSUInteger proIndex = self.curIndex;
    NSUInteger cityIndex = [pickerView selectedRowInComponent:1];
    L8Provinces *province = self.provinces[proIndex];
    self.city.text = [NSString stringWithFormat:@"%@,%@",province.name,province.cities[cityIndex]];

}


#pragma mark - ControllerMethod

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.birthday.delegate = self;
    self.city.delegate = self;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale *local = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = local;
    self.birthday.inputView = datePicker;
    [datePicker addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    AccesseryView *accesseryView = [AccesseryView accessoryView];
    accesseryView.myDelegate = self;
    self.accessoryView = accesseryView;
    self.birthday.inputAccessoryView = accesseryView;
    
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    self.pickerView = pickerView;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    self.city.inputView = pickerView;
    self.city.inputAccessoryView = accesseryView;
}

#pragma mark - TextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.birthday) {
        self.accessoryView.previous.enabled = NO;
        self.accessoryView.next.enabled = YES;
    }else
    {
        self.accessoryView.previous.enabled = YES;
        self.accessoryView.next.enabled = NO;
    }
}

#pragma mark DatePickerDelegate

-(void)valueChanged:(UIDatePicker *)datePicker
{
    NSDate *date = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *strDate = [dateFormatter stringFromDate:date];
    self.birthday.text = strDate;
}

#pragma mark - AccessoryViewDelegate

-(void)accesseryView:(AccesseryView *)accessserView buttonClickForType:(AccesseryViewButtonType)type
{
    switch (type) {
        case AccesseryViewButtonTypePrevious:
            [self.birthday becomeFirstResponder];
            break;
        case AccesseryViewButtonTypeNext:
            [self.city becomeFirstResponder];
            break;
        case AccesseryViewButtonTypeDone:
            [self.view endEditing:YES];
        default:
            break;
    }
}

@end
