//
//  NSArray_Map.m
//  benchObjC
//
//  Created by Regis Cridlig on 4/26/16.
//  Copyright © 2016 Regis Cridlig. All rights reserved.
//

#import "NSArray_Map.h"

@implementation NSArray (Map)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:[self count]];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [result addObject:block(obj, idx)];
    }];
    return result;
}

+ (NSArray*)init:(int)count generator:(id (^)(NSUInteger))generator {
    NSMutableArray* arr = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger i = 0; i < count; i++) {
        [arr addObject:generator(i)];
    }
    return arr;
}

@end