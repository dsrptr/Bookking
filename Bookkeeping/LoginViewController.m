//
//  ViewController.m
//  Bookkeeping
//
//  Created by MartinLi on 15-3-2.
//  Copyright (c) 2015年 Club. All rights reserved.
//
#import <Security/Security.h>
#import "LoginViewController.h"
#import <CoreFoundation/CoreFoundation.h>
#import "SharedData.h"
#import "ShareAction.h"
@interface LoginViewController ()
@property (nonatomic,strong) GesturePasswordView * gesturePasswordView;
@end

@implementation LoginViewController
{
    NSString * previousString;
    NSString * password;
    SharedData *sharedData;

    
}
@synthesize gesturePasswordView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.gesturePasswordView.backgroundColor=[UIColor redColor];
    previousString = [NSString string];
    sharedData=[SharedData sharedInstance];
    password=sharedData.password;
    NSLog(@"password:%@",password);
    if ([password isEqualToString:@""]) {
        [self reset];
    }else{
        [self verify];
    }
}
#pragma -mark 验证手势密码
- (void)verify{
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setRerificationDelegate:self];
    [gesturePasswordView.tentacleView setStyle:1];
    [gesturePasswordView setGesturePasswordDelegate:self];
    [self.view addSubview:gesturePasswordView];
}

#pragma -mark 重置手势密码
- (void)reset{
    gesturePasswordView = [[GesturePasswordView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [gesturePasswordView.tentacleView setResetDelegate:self];
    [gesturePasswordView.tentacleView setStyle:2];
    [gesturePasswordView.imgView setHidden:YES];
    [gesturePasswordView.forgetButton setHidden:YES];
    [gesturePasswordView.changeButton setHidden:YES];
    [self.view addSubview:gesturePasswordView];
}
- (BOOL)verification:(NSString *)result{
//    NSLog(@"result:%@,password:%@,result,password");
    if ([result isEqualToString:password]) {
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"输入正确"];
//        [self.gesturePasswordView removeFromSuperview];
        [self dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }
    [gesturePasswordView.state setTextColor:[UIColor redColor]];
    [gesturePasswordView.state setText:@"手势密码错误"];
    return NO;
}
- (BOOL)resetPassword:(NSString *)result{
    if ([previousString isEqualToString:@""]) {
        previousString=result;
        [gesturePasswordView.tentacleView enterArgin];
        [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
        [gesturePasswordView.state setText:@"请验证输入密码"];
        return YES;
    }
    else {
        if ([result isEqualToString:previousString]) {
            sharedData.password=result;
            sharedData.loginStatus=@"YES";
            NSLog(@"%@,%@",result,sharedData.password);
            [gesturePasswordView.state setTextColor:[UIColor colorWithRed:2/255.f green:174/255.f blue:240/255.f alpha:1]];
            [gesturePasswordView.state setText:@"已保存手势密码"];
            [self dismissViewControllerAnimated:YES completion:nil];
            return YES;
        }
        else{
            previousString =@"";
            [gesturePasswordView.state setTextColor:[UIColor redColor]];
            [gesturePasswordView.state setText:@"两次密码不一致，请重新输入"];
            return NO;
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark 清空记录
- (void)clear{
    sharedData=nil;
}

#pragma -mark 改变手势密码
- (void)change{
    sharedData.password=@"";
    sharedData.loginStatus=@"NO";
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"change");
}

#pragma -mark 忘记手势密码
- (void)forget{
    sharedData.password=@"";
    sharedData.loginStatus=@"NO";
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"forget");
}
@end
