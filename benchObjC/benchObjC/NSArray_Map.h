//
//  NSArray_Map.h
//  benchObjC
//
//  Created by Regis Cridlig on 4/26/16.
//  Copyright © 2016 Regis Cridlig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Map)

- (NSArray *)mapObjectsUsingBlock:(id (^)(id obj, NSUInteger idx))block;

+ (NSArray*)init:(int)count generator:(id (^)(NSUInteger))generator;

@end
