//
//  L8Student.h
//  KVO
//
//  Created by 李亮 on 15/6/6.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@class L8Dog;

@interface L8Student : NSObject

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *fullName;
@property (assign, nonatomic) int age;
@property (strong, nonatomic) NSMutableArray *dogs;
@property (strong, nonatomic) NSMutableArray *friends;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSMutableDictionary *dictionary;

-(void)insertObject:(NSString *)object inFriendsAtIndex:(NSUInteger)index;
-(void)removeObjectFromFriendsAtIndex:(NSUInteger)index;
-(void)replaceFriendsAtIndexes:(NSIndexSet *)indexes withFriends:(NSArray *)array;
-(void)removeObjectFromFriends:(NSString *)obj;

-(void)addDictionaryWithObj:(NSString *)obj key:(NSString *)key;
-(void)removeDictionaryWithKey:(NSString *)key;

@end
