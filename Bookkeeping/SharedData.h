//
//  SharedData.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-4.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SharedData : NSObject
@property(nonatomic,strong)NSString *loginStatus;
@property(nonatomic,strong)NSString *startStatus;
@property(nonatomic,strong)NSString *loginname;
@property(nonatomic,strong)NSString *password;
@property(nonatomic,strong)NSString *statart;
+(id)sharedInstance;
@end
