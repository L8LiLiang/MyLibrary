//
//  main.m
//  Predicate
//
//  Created by 李亮 on 15/4/16.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Human : NSObject
@property (nonatomic,readwrite,assign) NSUInteger age;
@property (nonatomic,readwrite,strong) NSString *name;
@property (nonatomic,readwrite,strong) NSArray *friends;
-(instancetype)initWithName:(NSString*)name andAge:(NSUInteger)age;

+(instancetype)humanWithName:(NSString*)name andAge:(NSUInteger)age;
@end

@implementation Human

-(instancetype)initWithName:(NSString*)name andAge:(NSUInteger)age
{
    if (self = [super init]) {
        self.name = name;
        self.age = age;
    }
    return  self;
}
+(instancetype)humanWithName:(NSString*)name andAge:(NSUInteger)age
{
    return [[self alloc] initWithName:name andAge:age];
}
-(NSString*)description
{
    return [NSString stringWithFormat:@"%@",self.name];
}
- (void)dealloc
{
    NSLog(@"Human dealloced");
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
    //谓词用于单个对象
        Human *likeqiang = [Human humanWithName:@"likeqiang" andAge:61];
        Human *xijinping = [Human humanWithName:@"xijinping" andAge:63];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == 'likeqiang'"];
        BOOL match = [predicate evaluateWithObject:likeqiang];
        if (match) {
            NSLog(@"likeqiang match");
        }
        match = [predicate evaluateWithObject:xijinping];
        if (match) {
            NSLog(@"xijinping match");
        }
    //键路径
        NSPredicate *predicateWithKeyPath = [NSPredicate predicateWithFormat:@"self.age > 62"];
        match = [predicateWithKeyPath evaluateWithObject:likeqiang];
        if (match) {
            NSLog(@"likeqiang match predicateWithKeyPath");
        }
        match = [predicateWithKeyPath evaluateWithObject:xijinping];
        if (match) {
            NSLog(@"xijinping match predicateWithKeyPath");
        }
    //数组过滤，生成新数组
        Human *wangqishan = [Human humanWithName:@"wangqishan" andAge:55];
        Human *zhanggaoli = [Human humanWithName:@"zhanggaoli" andAge:66];
        NSArray *lingdaoren = @[xijinping,likeqiang,wangqishan,zhanggaoli];
        NSArray *ageBig60 = [lingdaoren filteredArrayUsingPredicate:predicateWithKeyPath];
        NSLog(@"%@",ageBig60);
    //数组过滤，修改原数组
        NSMutableArray *changwei = [NSMutableArray arrayWithArray:lingdaoren];
        [changwei filterUsingPredicate:predicateWithKeyPath];
        NSLog(@"%@",changwei);
    //通过格式说明符创建谓词
        NSPredicate *formatPredicate = [NSPredicate predicateWithFormat:@"self.age > %d",58];
        NSArray *ageBig58 = [lingdaoren filteredArrayUsingPredicate:formatPredicate];
        NSLog(@"%@",ageBig58);
    //通过%@插入字符串
        NSPredicate *formatPredicate2 = [NSPredicate predicateWithFormat:@"name == %@",@"wangqishan"];
        NSArray *nameWqs = [lingdaoren filteredArrayUsingPredicate:formatPredicate2];
        NSLog(@"%@",nameWqs);
    //通过%K指定键路径
        NSPredicate *formatPredicate3 = [NSPredicate predicateWithFormat:@"%K == %@",@"name",@"wangqishan"];
        NSArray *nameWqs2 = [lingdaoren filteredArrayUsingPredicate:formatPredicate3];
        NSLog(@"%@",nameWqs2);
   //通过变量创建谓词
        NSPredicate *tmpPredicate = [NSPredicate predicateWithFormat:@"name = $NAME"];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"likeqiang",@"NAME", nil];
        predicate = [tmpPredicate predicateWithSubstitutionVariables:dict];
        NSArray *result = [lingdaoren filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
    //运算符
        predicate = [NSPredicate predicateWithFormat:@"(age > 60) AND (name CONTAINS 'xi')"];
        result = [lingdaoren filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
        
        predicate = [NSPredicate predicateWithFormat:@"age BETWEEN {50,63}"];
        result = [lingdaoren filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
        
        predicate = [NSPredicate predicateWithFormat:@"age IN {50,66,63}"];
        result = [lingdaoren filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
    //SELF
        NSArray *stringArray = @[@"likeqiang",@"xijinping",@"zhanggaoli",@"XiJinPing"];
        predicate = [NSPredicate predicateWithFormat:@"SELF > 'xi'"];
        result = [stringArray filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
    //字符串运算符
        predicate = [NSPredicate predicateWithFormat:@"!(self BEGINSWITH 'Xi')"];
        result = [stringArray filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
    //LIKE
        predicate = [NSPredicate predicateWithFormat:@"self LIKE '?iJ*'"];
        result = [stringArray filteredArrayUsingPredicate:predicate];
        NSLog(@"%@",result);
   


        

    }
    return 0;
}
