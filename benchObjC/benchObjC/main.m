//
//  main.m
//  benchObjC
//
//  Created by Regis Cridlig on 4/26/16.
//  Copyright © 2016 Regis Cridlig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray_Map.h"

void rss() {
    system([@"echo $(expr `ps -o rss= -p " stringByAppendingFormat:@"%d%@", getpid(), @"` / 1024) MB"].UTF8String);
}

const NSUInteger num_rows = 100000;
const NSUInteger num_cols = 10;
NSUInteger counter = 0;
NSString* xx;

NSString* (^gen)(NSUInteger) = ^(NSUInteger _){
    counter++;
    return [NSString stringWithFormat:@"%lu%@", counter, xx];
};

NSString* makeCSV() {
    NSArray* data = [NSArray init:num_rows generator:^(NSUInteger _) {
        return [NSArray init:num_cols generator:gen];
    }];
    printf("%lu\n", counter);
    NSString* csv = [[data mapObjectsUsingBlock:^(NSArray* row, NSUInteger idx)
                      { return [row componentsJoinedByString:@","]; }] 
                     componentsJoinedByString:@"\n"];
    rss();
    return csv;
}
    
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDate* time_begin = [NSDate date];
        
        NSString* x = @"x";
        xx = [@"" stringByPaddingToLength:1000 withString:x startingAtIndex:0];
        
        rss();
        
        for (int i = 1; i <= 10; i++) {
            printf("%lu\n", makeCSV().length);
        }
    
        printf("%.2f\n", [[NSDate date] timeIntervalSinceDate:time_begin]);
    }
    return 0;
}
