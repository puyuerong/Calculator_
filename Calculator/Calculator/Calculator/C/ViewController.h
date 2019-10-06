//
//  ViewController.h
//  Calculator
//
//  Created by 蒲悦蓉 on 2000/1/1.
//  Copyright © 2000 蒲悦蓉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "View.h"
#import "Model.h"
@interface ViewController : UIViewController
<ViewDelegate>
@property Model *model;
@end

