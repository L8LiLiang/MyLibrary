//
//  ViewController.m
//  KVO
//
//  Created by 李亮 on 15/6/6.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "ViewController.h"
#import "L8Student.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *fistName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *friend;

@property (strong, nonatomic) L8Student *student;

@end

@implementation ViewController

-(void)dealloc
{
    [self.student removeObserver:self forKeyPath:@"fullName"];
    [self.student removeObserver:self forKeyPath:@"friends"];
    [self.student removeObserver:self forKeyPath:@"dictionary"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.student = [L8Student new];
    self.student.firstName = @"liang";
    self.student.lastName = @"li";
    
    [self.student addObserver:self forKeyPath:@"fullName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [self.student addObserver:self forKeyPath:@"friends" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [self.student addObserver:self forKeyPath:@"dictionary" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
        
    self.fistName.text = self.student.firstName;
    self.lastName.text = self.student.lastName;
    self.fullName.text = self.student.fullName;
    
    self.fistName.delegate = self;
    self.lastName.delegate = self;
    
    NSLog(@"%@",[self.student valueForKeyPath:@"dogs.@sum.age"]);
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"fullName"]) {
        self.fullName.text = [change valueForKey:NSKeyValueChangeNewKey];
        NSLog(@"%@",change);
    }else if ([keyPath isEqualToString:@"friends"]){
        NSLog(@"friends:%@",change);
    }else if([keyPath isEqualToString:@"dictionary"]){
        NSLog(@"dictionary:%@",change);
    }
}

- (IBAction)editingChanged:(UITextField *)sender {
//    if (sender.tag == 0) {
//        self.student.firstName = sender.text;
//    }else
//    {
//        self.student.lastName = sender.text;
//    }
}
- (IBAction)editingDidEnd:(UITextField *)sender {
    if (sender.tag == 0) {
        self.student.firstName = sender.text;
    }else
    {
        self.student.lastName = sender.text;
    }

}
- (IBAction)addClick:(id)sender {
    //Test MutableArray
//    [self.student insertObject:self.friend.text inFriendsAtIndex:self.student.friends.count];
    //self.student.friends = [NSMutableArray arrayWithObject:self.friend.text];
    
    //可行 官方推荐
//    NSMutableArray *mutableArray = [self.student mutableArrayValueForKey:@"friends"];
//    [mutableArray addObject:self.friend.text];
    
    //Test MutableDictionary
    //[self.student.dictionary setObject:@"3" forKey:@"key3"];
//    self.student.dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"3",@"key3", nil];
    [self.student addDictionaryWithObj:self.friend.text key:self.friend.text];
    
    
}
- (IBAction)deleteClick:(id)sender {
//    [self.student.friends removeObjectAtIndex:0];
    [self.student removeObjectFromFriendsAtIndex:0];
//    [self.student removeObjectFromFriends:self.friend.text];
    
//    NSMutableArray *mutableArray = [self.student mutableArrayValueForKey:@"friends"];
//    [mutableArray removeObject:self.friend.text];
    
//    [self.student removeDictionaryWithKey:self.friend.text];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}
- (IBAction)backgroundTouchDown:(id)sender {
    [self.view endEditing:YES];
}


@end
