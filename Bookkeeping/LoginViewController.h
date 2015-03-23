//
//  ViewController.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-2.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TentacleView.h"
#import "GesturePasswordView.h"
@interface LoginViewController : UIViewController<VerificationDelegate,ResetDelegate,GesturePasswordDelegate>
-(void)clear;
@end

