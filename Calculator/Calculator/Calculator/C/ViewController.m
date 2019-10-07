//
//  ViewController.m
//  Calculator
//
//  Created by 蒲悦蓉 on 2000/1/1.
//  Copyright © 2000 蒲悦蓉. All rights reserved.
//

#import "ViewController.h"
#import "View.h"
@interface ViewController ()
@property View *calculatorView;
@property NSInteger count;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _model = [[Model alloc] init];
    _calculatorView = [[View alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_calculatorView];
    _calculatorView.delegate = self;
    _model.allArray = [[NSMutableArray alloc] init];
    _model.tempArray = [[NSMutableArray alloc] init];

}
- (void)ClickButton:(UIButton *)btn {
    _calculatorView.answerLabel.text = @"";
    _calculatorView.expressionStr = [_calculatorView.expressionStr stringByAppendingString: btn.titleLabel.text];
    _calculatorView.expressionLabel.text = _calculatorView.expressionStr;
    if ((btn.tag >= 0) && (btn.tag <= 10)) {          /*摁了数字或小数点*/
        NSString *str = btn.titleLabel.text;
        _calculatorView.numberString = [_calculatorView.numberString stringByAppendingString: str];
        if ([btn.titleLabel.text isEqualToString:@"."]) {
            _count++;
        }
    }
    if ((btn.tag > 100) && (btn.tag <= 106)) {             /*摁了加减乘除或括号*/
        if ([_calculatorView.numberString length] != 0) {     /*判断数字有没有问题*/
            NSLog(@"count = %ld", _count);
            if (([_calculatorView.numberString characterAtIndex:[_calculatorView.numberString length] - 1] == '.') || ([_calculatorView.numberString characterAtIndex:0] == '.') || (_count > 1)){
                _count = 0;
                [self error];
                return;
            } else {
                if (([btn.titleLabel.text isEqualToString: @"("]) && ([_calculatorView.numberString length] != 0)) {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    [btn setTitle:@"*" forState:UIControlStateNormal];
                    
                    btn.tag = 101;
                    [self ClickButton:btn];
                    _calculatorView.expressionStr = [_calculatorView.expressionStr substringToIndex:[_calculatorView.expressionStr length] - 1];
                    _calculatorView.expressionLabel.text = _calculatorView.expressionStr;
                } else {
                    [_model PushInto: _calculatorView.numberString];
                    _calculatorView.numberString = @"";
                    _count = 0;
                }
            }
        }
        if ([_model.tempArray count] == 0) {
            if ([btn.titleLabel.text isEqualToString:@")"]) {
                [self error];
            } else {
                if (([btn.titleLabel.text isEqualToString: @"-"]) && ([_model.allArray count] == 0)) {
                    _calculatorView.numberString = [_calculatorView.numberString stringByAppendingString: @"-"];
                    NSLog(@"number = %@", _calculatorView.numberString);
                    return;
                } else {
//                    while (([_model Compare: @"-"] == 0) && ([_model.tempArray count] != 0)) {
//                        [_model PushInto: @"nil"];
//                    }
                    [_model tempPushIntoSymbol:btn.titleLabel.text];
                }
            }
        } else {
            if (([btn.titleLabel.text isEqualToString: @"-"]) && ([_calculatorView.expressionStr characterAtIndex: [_calculatorView.expressionStr length] - 2] == '(')) {
                
                 _calculatorView.numberString = [_calculatorView.numberString stringByAppendingString: @"-"];
                return;
            }
        
            if ([_model Compare:btn.titleLabel.text] == 0) {
                if ([btn.titleLabel.text isEqualToString: @"("]) {
                    [_model tempPushIntoSymbol: btn.titleLabel.text];
                } else {
                    while (([_model.tempArray count] != 0) && ([_model Compare: @"-"] == 0)) {
                        [_model PushInto: @"nil"];
                    }
                    [_model tempPushIntoSymbol:btn.titleLabel.text];
                }
            } else {
                if ([btn.titleLabel.text isEqualToString:@")"]) {
                    for (int i = (int)[_model.tempArray count] - 1; ; i--){
                        NSLog(@"i = %d", i);
                        
                    
                        if ([_model.tempArray[i] isEqualToString:@"("]) {
                            int j = (int)[_model.tempArray count];
                            j = j - 1;
                            while (1) {
                                NSLog(@"%d", j);
                                if (j == i) {
                                    [_model.tempArray removeObjectAtIndex: i];
                                    return;
                                }
                                [_model.allArray addObject:_model.tempArray[j]];
                                [_model.tempArray removeObjectAtIndex:j];
                                j--;
                            }
                        }
                        if (i == 0) {
                            [self error];
                            break;
                        }
                    }
                } else {
                    [_model tempPushIntoSymbol:btn.titleLabel.text];
                }
            }
        }
    }
    if (btn.tag == -1) {                           /*摁了AC*/
        [_model.tempArray removeAllObjects];
        [_model.allArray removeAllObjects];
        _calculatorView.numberString = @"";
        _calculatorView.answerLabel.text = @"0";
        _calculatorView.expressionLabel.text = @"";
        _calculatorView.expressionStr = @"";
    }
    if (btn.tag == 100) {                            /*摁了=*/
        
        if ([_calculatorView.numberString length] != 0) {
            if (([_calculatorView.numberString characterAtIndex:[_calculatorView.numberString length] - 1] == '.') || ([_calculatorView.numberString characterAtIndex:0] == '.') || (_count > 1)){
                _count = 0;
                [self error];
                return;
            } else {
                [_model PushInto:_calculatorView.numberString];
            }
        }
        if (([_model.tempArray count] == 0) && ([_model.allArray count] == 0)) {
            [self error];
            return;
        }
        while ([_model.tempArray count] != 0) {
            [_model PushInto:@"nil"];
        }
        NSLog(@"tmepArray = %@, allArray = %@, numberStr = %@", _model.tempArray, _model.allArray, _calculatorView.numberString);
        while (1) {
            NSInteger flag = 0;
            for (int i = 0; i < [_model.allArray count]; i++) {
                if (([_model.allArray[i] isEqualToString:@"+"]) || ([_model.allArray[i] isEqualToString:@"-"]) || ([_model.allArray[i] isEqualToString:@"*"]) || ([_model.allArray[i] isEqualToString:@"/"])){
                    if (i <= 1) {
                        [self error];
                        flag = 1;
                        break;
                    } else {
                        if ([_model.allArray[i] isEqualToString:@"+"]) {
                            float number1 = [_model Transform:_model.allArray[i - 2]];
                            float number2 = [_model Transform:_model.allArray[i - 1]];
                            _model.allArray[i] = [NSString stringWithFormat: @"%f", number1 + number2];
                            [_model.allArray removeObjectAtIndex: i - 1];
                            [_model.allArray removeObjectAtIndex: i - 2];
                            break;
                        }
                        if ([_model.allArray[i] isEqualToString:@"-"]) {
                            float number1 = [_model Transform:_model.allArray[i - 2]];
                            float number2 = [_model Transform:_model.allArray[i - 1]];
                            _model.allArray[i] = [NSString stringWithFormat: @"%f", number1 - number2];
                            [_model.allArray removeObjectAtIndex: i - 1];
                            [_model.allArray removeObjectAtIndex: i - 2];
                            break;
                        }
                        if ([_model.allArray[i] isEqualToString:@"*"]) {
                            float number1 = [_model Transform:_model.allArray[i - 2]];
                            float number2 = [_model Transform:_model.allArray[i - 1]];
                            NSLog(@"%f", number1 * number2);
                            _model.allArray[i] = [NSString stringWithFormat: @"%f", number1 * number2];
                            [_model.allArray removeObjectAtIndex: i - 1];
                            [_model.allArray removeObjectAtIndex: i - 2];
                            break;
                        }
                        if ([_model.allArray[i] isEqualToString:@"/"]) {
                            float number1 = [_model Transform:_model.allArray[i - 2]];
                            float number2 = [_model Transform:_model.allArray[i - 1]];
                            _model.allArray[i] = [NSString stringWithFormat: @"%f", number1 / number2];
                            [_model.allArray removeObjectAtIndex: i - 1];
                            [_model.allArray removeObjectAtIndex: i - 2];
                            break;
                        }
                    }
                    
                }
                if (i == [_model.allArray count] - 1) {
                    if (([_model.allArray count] == 1) && ([_model JudgeSymbol:_model.allArray[0]] == NO)) {
                        break;
                    } else {
                        [self error];
                        flag = 1;
                    }
                }
            }
            NSLog(@"allArray = %@", _model.allArray);
            if (flag == 1) {
                break;
            }
            NSLog(@"count = %ld", [_model.allArray count]);
            if ([_model.allArray count] == 1) {
                if ([_model Location: _model.allArray[0]] > 6) {
                    NSNumber *num = [NSNumber numberWithFloat: [_model Transform: _model.allArray[0]]];
                    NSString *str = [NSNumberFormatter localizedStringFromNumber: num numberStyle:NSNumberFormatterScientificStyle];
                    _calculatorView.answerLabel.text = str;
                } else {
                    _calculatorView.answerLabel.text = _model.allArray[0];
                }
                [_model.tempArray removeAllObjects];
                [_model.allArray removeAllObjects];
                _calculatorView.numberString = @"";
//                _calculatorView.expressionLabel.text = @"";
                _calculatorView.expressionStr = @"";
                break;
            }
        }
    }
    NSLog(@"tmepArray = %@, allArray = %@, numberStr = %@", _model.tempArray, _model.allArray, _calculatorView.numberString);
}
- (void)error {
    [_model.tempArray removeAllObjects];
    [_model.allArray removeAllObjects];
    _calculatorView.numberString = @"";
    _calculatorView.answerLabel.text = @"error";
//    _calculatorView.expressionLabel.text = @"";
    _calculatorView.expressionStr = @"";
}
@end
