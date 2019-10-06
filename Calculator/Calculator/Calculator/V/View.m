//
//  View.m
//  Calculator
//
//  Created by 蒲悦蓉 on 2019/10/3.
//  Copyright © 2019 蒲悦蓉. All rights reserved.
//

/*
 =    100;
 +    101;
 -    102;
 *    103;
 /    104;
 0 - 9     0 - 9;
 .    10;
 AC   -1;
 (    105;
 )    106;
 */

#import "View.h"
#import "Masonry.h"
@implementation View
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    int width = [UIScreen mainScreen].bounds.size.width;
    int higth = [UIScreen mainScreen].bounds.size.height;
    self.backgroundColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.00f];
    
    self.numberString = @"";
    self.expressionStr = @"";
    _expressionLabel = [[UILabel alloc] init];
    [self addSubview: _expressionLabel];
    _expressionLabel.textColor = [UIColor whiteColor];
    _expressionLabel.font = [UIFont systemFontOfSize:32];
    _expressionLabel.numberOfLines = 3;
    _expressionLabel.textAlignment = NSTextAlignmentRight;
    [_expressionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(0.2 * higth));
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
    }];
    
    _answerLabel = [[UILabel alloc] init];
    [self addSubview:_answerLabel];
    _answerLabel.textColor = [UIColor whiteColor];
    _answerLabel.font = [UIFont systemFontOfSize:32];
    _answerLabel.textAlignment = NSTextAlignmentRight;
    [_answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
        make.height.equalTo(@(0.15 * higth));
        make.top.equalTo(self).offset(0.2 * higth);
        make.left.equalTo(self).offset(0);
    }];
    
    for (int i = 0; i <= 4; i++) {
        for (int j = 1; j <= 4; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [btn addTarget:self action:@selector(ClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            /* ================== 0 那个键 ===========================*/
    
            if ((i == 0) && (j == 1)) {
                btn.titleLabel.textAlignment = NSTextAlignmentLeft;
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    int hight = width * 0.19;
                    make.height.equalTo(@(hight));
                    int gap = (width - hight * 4) / 5;
                    make.width.equalTo(@(hight * 2 + gap));
                    make.left.equalTo(self).offset(gap);
                    make.bottom.equalTo(self).offset(-20);
                }];
                [btn setTitle:@"0" forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f]];
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = (width * 0.19) / 2;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize: 32];
                btn.tag = 0;
                j++;
            } else {
                
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    int hight = width * 0.19;
                    make.width.equalTo(@(hight));
                    make.height.equalTo(@(hight));
                    int gap = (width - hight * 4) / 5;
                    make.bottom.equalTo(self).offset(-(i * (hight + 20) + 20));
                    //(i * (int)make.width + 20 * i);
                    make.left.equalTo(self).offset(j * (hight + gap) - hight);
                    //(width * (j - 1) + j * gap);
                }];
                btn.layer.masksToBounds = YES;
                btn.layer.cornerRadius = (width * 0.19) / 2;
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize: 32];
                btn.titleLabel.textAlignment = NSTextAlignmentCenter;
                /*======================= 第一行 ==============================*/

                if ((i == 4) && (j != 4)) {
                    [btn setBackgroundColor:[UIColor colorWithRed:0.65f green:0.65f blue:0.65f alpha:1.00f]];
                    if (j == 1) {
                        [btn setTitle:@"AC" forState:UIControlStateNormal];
                        btn.tag = -1;
                    }
                    if (j == 2) {
                        [btn setTitle:@"(" forState:UIControlStateNormal];
                        btn.tag = 105;
                    }
                    if (j == 3) {
                        [btn setTitle:@")" forState:UIControlStateNormal];
                        btn.tag = 106;
                    }
                    continue;
                }

                /*======================= 第四列 ==============================*/

                if (j == 4) {
                    [btn setBackgroundColor:[UIColor colorWithRed:0.97f green:0.58f blue:0.19f alpha:1.00f]];
                    if (i == 0) {
                        [btn setTitle:@"=" forState:UIControlStateNormal];
                        btn.tag = 100;
                    }
                    if (i == 1) {
                        [btn setTitle:@"+" forState:UIControlStateNormal];
                        btn.tag = 101;
                    }
                    if (i == 2) {
                        [btn setTitle:@"-" forState:UIControlStateNormal];
                        btn.tag = 102;
                    }
                    if (i == 3) {
                        [btn setTitle:@"*" forState:UIControlStateNormal];
                        btn.tag = 103;
                    }
                    if (i == 4) {
                        [btn setTitle:@"/" forState:UIControlStateNormal];
                        btn.tag = 104;
                    }
                    continue;
                }

                /*=================== 其他的 =================================*/


                [btn setBackgroundColor:[UIColor colorWithRed:0.20f green:0.20f blue:0.20f alpha:1.00f]];

                if ((i == 0) && (j == 3)) {
                    [btn setTitle:@"." forState:UIControlStateNormal];
                    btn.tag = 10;
                    continue;
                }
                [btn setTitle:[NSString stringWithFormat:@"%d", i * 3 + j - 3] forState:UIControlStateNormal];
                btn.tag = i * 3 + j - 3;
            }
        }
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
- (void)ClickButton:(UIButton*)btn {
    [_delegate ClickButton:btn];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
