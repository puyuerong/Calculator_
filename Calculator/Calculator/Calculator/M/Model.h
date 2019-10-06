//
//  Model.h
//  Calculator
//
//  Created by 蒲悦蓉 on 2019/10/4.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Model : NSObject
@property NSMutableArray *tempArray;
@property NSMutableArray *allArray;

- (void)tempPushIntoSymbol: (NSString*)symbol;
- (void)tempPushOffSymbol: (NSString*)symbol;
- (void)PushInto: (NSString*)str;
- (NSInteger)Compare: (NSString*)str;
- (float)Transform: (NSString*)str;
- (BOOL)JudgeSymbol: (NSString*)str;
- (NSInteger)Location: (NSString*)str;
- (NSInteger)Point: (NSString*)str;      /* 小数点g后几位 */
@end

NS_ASSUME_NONNULL_END
