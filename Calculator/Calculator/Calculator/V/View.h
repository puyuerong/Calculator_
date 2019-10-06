//
//  View.h
//  Calculator
//
//  Created by 蒲悦蓉 on 2019/10/3.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ViewDelegate <NSObject>

- (void)ClickButton:(UIButton*)btn;

@end
@interface View : UIView
@property UILabel *expressionLabel;
@property UILabel *answerLabel;
@property NSString *expressionStr;
@property NSString *numberString;
@property id<ViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
