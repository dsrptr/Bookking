//
//  NString+NsDate.m
//  Bookkeeping
//
//  Created by MartinLi on 15-3-22.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "NString+NsDate.h"

@implementation NString_NsDate

/*计算这个月有多少天*/
+ (NSUInteger)numberOfDaysInCurrentMonthwitDate:(NSDate *)data
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:data].length;
}
//获取年月日对象
+ (NSDateComponents *)YMDComponentswitDate:(NSDate *)data
{
    return [[NSCalendar currentCalendar] components:
            NSYearCalendarUnit|
            NSMonthCalendarUnit|
            NSDayCalendarUnit|
            NSWeekdayCalendarUnit fromDate:data];
}

+ (NSDate *)dateFromString:(NSString *)dateString
{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    //    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
   
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
    
}


//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}
@end
