//
//  SharedData.m
//  Bookkeeping
//
//  Created by MartinLi on 15-3-4.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "SharedData.h"

@implementation SharedData
+(SharedData *)sharedInstance{
    static SharedData *sharedUser = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedUser = [[SharedData alloc] init];
    });
    return sharedUser;
}
-(void)setLoginStatus:(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginStatus forKey:@"loginStatus"];
    [userDefaults synchronize];
}

-(NSString *)loginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginStatus"];
}
-(void)setStatusStatus:(NSString *)startStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:startStatus forKey:@"startStatu"];
    [userDefaults synchronize];
}

-(NSString *)startStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:@"startStatu"];
}

-(void)setLoginname:(NSString *)loginname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:loginname forKey:@"loginname"];
    [userDefaults synchronize];
}

-(NSString *)loginname{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"loginname"];
}

-(void)setPassword:(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:password forKey:@"password"];
    [userDefaults synchronize];
}

-(NSString *)password{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"password"];
}

@end
