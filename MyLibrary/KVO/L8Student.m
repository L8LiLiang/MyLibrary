//
//  L8Student.m
//  KVO
//
//  Created by 李亮 on 15/6/6.
//  Copyright (c) 2015年 李亮. All rights reserved.
//

#import "L8Student.h"
#import "L8Dog.h"

@implementation L8Student

-(NSMutableDictionary *)dictionary
{
    if (!_dictionary) {
        _dictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"key1",@"2",@"key2", nil];
    }
    return _dictionary;
}

-(NSArray *)array
{
    if (!_array) {
        _array = @[@"ddd",@"ggg"];
    }
    return _array;
}

-(NSMutableArray *)dogs
{
    if (!_dogs) {
        _dogs = [[NSMutableArray alloc] init];
        
        L8Dog *dog1 = [L8Dog new];
        dog1.name = @"dog1";
        dog1.age = 10;
        L8Dog *dog2 = [L8Dog new];
        dog2.name = @"dog2";
        dog2.age = 2;
        [_dogs addObject:dog1];
        [_dogs addObject:dog2];
    }
    return _dogs;
}

-(NSMutableArray *)friends
{
    if (!_friends) {
        _friends = [NSMutableArray arrayWithObjects:@"fanlilei",@"zhaoliang", nil];
    }
    return  _friends;
}

-(NSString *)fullName
{
    return [NSString stringWithFormat:@"%@.%@",_firstName,_lastName];
}

+(NSSet *)keyPathsForValuesAffectingFullName
{
    return [NSSet setWithObjects:@"firstName",@"lastName", nil];
}



//必须要实现这些方法，并且必须通过调用这些方法修改array内容时，才能发送通知,
//通过整体赋值方式修改array，能自动发送通知，不需要实现下面的方法
-(void)insertObject:(NSString *)object inFriendsAtIndex:(NSUInteger)index
{
    
    [_friends insertObject:object atIndex:index];
}

-(void)removeObjectFromFriendsAtIndex:(NSUInteger)index
{
    [_friends removeObjectAtIndex:index];
}

-(void)removeObjectFromFriends:(NSString *)obj
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:[self.friends indexOfObject:obj]];
    [self willChange:NSKeyValueChangeRemoval valuesAtIndexes:indexSet forKey:@"friends"];
    [self.friends removeObject:obj];
    [self didChange:NSKeyValueChangeRemoval valuesAtIndexes:indexSet forKey:@"friends"];
}

-(void)replaceFriendsAtIndexes:(NSIndexSet *)indexes withFriends:(NSArray *)array
{
    [_friends replaceObjectsAtIndexes:indexes withObjects:array];
}

-(void)addDictionaryWithObj:(NSString *)obj key:(NSString *)key
{
    //下面的方法只能用在set中，不能用在dictionary中
    //[self willChangeValueForKey:@"dictionary" withSetMutation:NSKeyValueUnionSetMutation usingObjects:[NSSet setWithObject:obj]];
//    [self didChangeValueForKey:@"dictionary" withSetMutation:NSKeyValueUnionSetMutation usingObjects:[NSSet setWithObject:obj]];

    [self willChangeValueForKey:@"dictionary"];
    [self.dictionary setObject:obj forKey:key];
    [self didChangeValueForKey:@"dictionary"];

}

-(void)removeDictionaryWithKey:(NSString *)key
{
    [self willChangeValueForKey:@"dictionary"];
    [self.dictionary removeObjectForKey:key];
    [self didChangeValueForKey:@"dictionary"];
}

+(BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
{
    BOOL automic = [super automaticallyNotifiesObserversForKey:key];
    return automic;
}


@end
