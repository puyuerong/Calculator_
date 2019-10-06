//
//  Model.m
//  Calculator
//
//  Created by 蒲悦蓉 on 2019/10/4.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import "Model.h"

@implementation Model

- (void)tempPushIntoSymbol:(NSString *)symbol {
    [_tempArray addObject:symbol];
}
- (void)tempPushOffSymbol:(NSString *)symbol {
    [_tempArray removeObjectAtIndex:([_tempArray count] - 1)];
}
- (void)PushInto:(NSString *)str {
    if (([str isEqualToString:@"("]) || ([str isEqualToString:@")"])) {
        return;
    }
    if ([str isEqualToString:@"nil"]) {
        [_allArray addObject:_tempArray[[_tempArray count] - 1]];
        [_tempArray removeObjectAtIndex:([_tempArray count] - 1)];
    } else {
        [_allArray addObject:str];
    }
}
- (NSInteger)Compare:(NSString *)str {
    NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:@"(", @"+", @"-", @"*", @"/", @")", nil];
    for (int i = 0; i < [array count]; i++) {
        if ([_tempArray[[_tempArray count] - 1] isEqualToString:array[i]]) {
            return 1;            /*直接进栈*/
        }
        if ([str isEqualToString:array[i]]) {
            return 0;             /*操作*/
        }
    }
    return 0;
}
- (float)Transform:(NSMutableString *)str {
    int flag = 0;
    float sum = 0, temp = 0, t = 0.0;
    temp = (int)[str characterAtIndex:0] - 48;
    if ([str length] > 1) {
        for (int i = 1; i < [str length]; i++) {
            if ([str characterAtIndex:i] == '.') {
                sum += temp;
                temp = 0.1 * ((int)[str characterAtIndex:++i] - 48);
                t = 0.01;
                flag = 1;
                continue;
            } else {
                if (flag == 0) {
                    temp = temp * 10 + (int)[str characterAtIndex:i] - 48;
                } else {
                    temp = temp + t * ((int)[str characterAtIndex:i] - 48);
                    t = 0.1 * t;
                }
            }
        }
        sum += temp;
    } else {
        sum = (int)[str characterAtIndex:0] - 48;
    }
    return sum;
}
- (BOOL)JudgeSymbol:(NSString *)str {
    if (([str isEqualToString: @"+"]) || ([str isEqualToString:@"-"]) || ([str isEqualToString:@"*"]) || ([str isEqualToString:@"/"]) || ([str isEqualToString: @"("]) || ([str isEqualToString: @")"])) {
        return YES;
    } else {
        return NO;
    }
}
- (NSInteger)Location: (NSString*)str {
    for (int i = 0; i < [str length]; i++) {
        if ([str characterAtIndex: i] == '.') {
            return i;
        }
    }
    if ([str length] > 6) {
        return 8;
    }
    return 0;
}
- (NSInteger)Point:(NSString *)str {
    NSInteger count = 0;
    for (int i = 0; i < [str length]; i++) {
        if ([str characterAtIndex: i] == '.') {
            count++;
            if (count > 6) {
                return 8;
            }
        }
    }
    return 0;
}
@end
