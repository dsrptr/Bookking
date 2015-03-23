//
//  NString+NsDate.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-22.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NString_NsDate : NSObject
/*计算这个月有多少天*/
+ (NSUInteger)numberOfDaysInCurrentMonthwitDate:(NSDate *)data;
//获取年月日对象
+ (NSDateComponents *)YMDComponentswitDate:(NSDate *)data;
+ (NSDate *)dateFromString:(NSString *)dateString;
//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date;
@end
