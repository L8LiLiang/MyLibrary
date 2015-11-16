//
//  L8Encode.m
//  Base64登陆
//
//  Created by 李亮 on 15/6/11.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8Encode.h"

@implementation L8Encode

//对url特殊符号进行编码
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http: www.ietf.org="" rfc="" rfc3986.txt="">)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)input,NULL,(CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
    return outputStr;
}

//url解码
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    return [input stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

//base64 编码 "加密" 密码     可以把任意的二进制数据 转换成字符串
+ (NSString *)encodeBase64:(NSString *)input{
    //不管是编码 还是加密  都是对二进制数据进行 操作
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

//base64 解码 "解密"
+ (NSString *)decodeBase64:(NSString *)input{
    //解码
    NSData *data = [[NSData alloc] initWithBase64EncodedString:input options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
