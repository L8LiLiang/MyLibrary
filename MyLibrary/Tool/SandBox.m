//
//  SandBox.m
//  MyLibrary
//
//  Created by 李亮 on 15/11/16.
//  Copyright © 2015年 李亮. All rights reserved.
//

#import "SandBox.h"

@implementation SandBox
- (void)demo{
    NSLog(@"HomeDirectory:%@",NSHomeDirectory());
    NSLog(@"DocumentsDir:%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));

    NSLog(@"DocumentsDir:%@",[[NSFileManager defaultManager] URLsForDirectory:NSApplicationDirectory inDomains:NSUserDomainMask]);

    NSLog(@"info.plist dir:%@",[[NSBundle mainBundle] URLForResource:@"Info" withExtension:@"plist"]);
}
@end
