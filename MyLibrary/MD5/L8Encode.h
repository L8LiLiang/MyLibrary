//
//  L8Encode.h
//  Base64登陆
//
//  Created by 李亮 on 15/6/11.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface L8Encode : NSObject
//对url特殊符号进行编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;
//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;
//base64 编码 "加密" 密码     可以把任意的二进制数据 转换成字符串
+ (NSString *)encodeBase64:(NSString *)input;
//base64 解码 "解密"
+ (NSString *)decodeBase64:(NSString *)input;
@end
