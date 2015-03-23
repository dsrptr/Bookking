//
//  ShareAction.m
//  Bookkeeping
//
//  Created by MartinLi on 15-3-4.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "ShareAction.h"
#import "FMDB.h"
#import "DateModel.h"
#define DEFAULT_VOID_COLOR [UIColor whiteColor]
@implementation ShareAction
+(void)createTabelwithFinalPath:(NSString *)finalPath0{
    NSFileManager *billmanage = [NSFileManager defaultManager];
    if ([billmanage fileExistsAtPath:finalPath0]==NO) {
        FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
        if ([billDB open]) {
            //账单表
            NSString *spl1=@"CREATE TABLE IF NOT EXISTS bill (id integer primary key autoincrement not null,type_id integer NOT NULL REFERENCES type (id),type_parent_id integer NOT NULL REFERENCES type (parent_id),address text,money text NOT NULL,time date NOT NULL,remark text)";
            //title 表标题
            //bill_type_id 记账类型 ：人情 生意 日常
            //consume_type 消费类型 支出 收入
            //money 钱
            //time 时间戳
            //status 状态 1正常 0 删除
            //账单类别表
            //备注
            NSString *spl2=@"CREATE TABLE IF NOT EXISTS type (id integer PRIMARY KEY autoincrement NOT NULL,title VARCHAR(20) NOT NULL,parent_id integer NOT NULL,remark TEXT NULL,add_time DATE NULL,pic_title text)";

            BOOL res0 = [billDB executeUpdate:spl1];
            BOOL res1 = [billDB executeUpdate:spl2];
            if (!res0) {
                NSLog(@"表1错误创建");
            }else{
                NSLog(@"表1成功创建");
            }
            if (!res1) {
                NSLog(@"表2错误创建");
            }else{
                NSLog(@"表2成功创建");
            }

        }else{
            NSLog(@"创建时打开错误");
        }
                NSDate *date = [NSDate date];
                NSString *sql1 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('旅游消费', '0', '','%@')",date];
                BOOL res1 = [billDB executeUpdate:sql1];
                if (!res1) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }
                NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('人情事故', '0', '','%@')",date];
                BOOL res2 = [billDB executeUpdate:sql2];
                if (!res2) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }  NSString *sql3 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('日常开支', '0', '','%@')",date];
                BOOL res3 = [billDB executeUpdate:sql3];
                if (!res3) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }
                NSString *sql5 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('充电学习', '0', '','%@')",date];
                BOOL res5 = [billDB executeUpdate:sql5];
                if (!res5) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }
                NSString *sql4 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('医疗开支', '0', '','%@')",date];
                BOOL res4 = [billDB executeUpdate:sql4];
                if (!res4) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }
                NSString *sql6 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('爱情基金', '0', '','%@')",date];
                BOOL res6 = [billDB executeUpdate:sql6];
                if (!res6) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }
        
            NSArray *typeSon =@[@"衣",@"食",@"住",@"行",@"领导",@"长辈",@"朋友",@"体检",@"吊水",@"养生",@"抓药",@"门诊"];
            NSArray *idArray =@[@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"1",@"2",@"3",@"4",@"6",@"6",@"6",@"5",@"5",@"5",@"5",@"5"];
        int k;
        k=0;
        for (int i=0; i<typeSon.count;i++) {
            if (i<4) {
                for (int j=0; j<4;j++ ) {
                   
                    NSString *sql8 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('%@', '%@', null,'%@')",typeSon[i],idArray[k],date];
                    NSLog(@"%@",sql8);
                    BOOL res6 = [billDB executeUpdate:sql8];
                    if (!res6) {
                        NSLog(@"插入出错");
                    }else{
                        NSLog(@"插入成功");
                    }
                    k++;
                }
            }else{
                k++;
                NSLog(@"%d",k);
                NSString *sql8 = [NSString stringWithFormat:@"INSERT INTO type ('title','parent_id','remark','add_time') VALUES ('%@', '%@', null,'%@')",typeSon[i],idArray[k-1],date];
                NSLog(@"%@",sql8);
                BOOL res6 = [billDB executeUpdate:sql8];
                if (!res6) {
                    NSLog(@"插入出错");
                }else{
                    NSLog(@"插入成功");
                }
            }
        }
        [billDB close];
    }else{
    
    }
}
+(void)selectTitleWithParentid:(NSString *)parent_id andFinalPath:(NSString *)finalPath0 withDone:(doneWithObject)done{
 FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
    NSLog(@"%@",finalPath0);
    if ([billDB open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from type where parent_id =%@",parent_id];
        NSLog(@"%@",sql);
        FMResultSet *result = [billDB executeQuery:sql];
        NSLog(@"%@",result);
        done(result);
        [billDB close];
    }else{
        NSLog(@"打开错误");
    }
}
+(void)selectDataWithTitle_id:(NSString *)title_id andandFinalPath:(NSString *)finalPath0 withDone:(doneWithObject)done{
    FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
    if ([billDB open]) {
        NSString *sql=[NSString stringWithFormat:@"select * from type where id =%@ ",title_id];
        FMResultSet *result = [billDB executeQuery:sql];
        done(result);
        [billDB close];
    }else{
        NSLog(@"打开错误");
    }
}

+(void)selectTitlewitFinalPath:(NSString *)finalPath0 withDone:(doneWithObject)done{
    FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
    if ([billDB open]) {
    NSString *sql7 = @"select a.* ,b.title as bill_type_son_title ,c.title as bill_type_title from bill as a,bill_type_son as b , bill_type as c where a.bill_type_son_id = b.id and b.parent_id = c.id";
    FMResultSet *result = [billDB executeQuery:sql7];
        done(result);
        [billDB close];
    }else{
        NSLog(@"打开错误");
    }
}

+(void)insertTitle:(NSString *)title andTypeId:(NSInteger )type_id andParentId:(NSInteger )parent_id andAddress:(NSString *)address andMone:(NSString *)mone andTime:(NSString *)time andRemark:(NSString *)remark andFinaPlpath:(NSString *)finalPath0 withDone:(doneWithObject)done{
    FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
    if ([billDB open]) {
    NSString *sql8 = [NSString stringWithFormat:@"INSERT INTO bill ('type_id','type_parent_id','address','money','time','remark') VALUES ('%ld','%ld','%@','%@','%@','%@')",(long)type_id,(long)parent_id,address,mone,time,remark];
        NSLog(@"%@",sql8);
        BOOL res = [billDB executeUpdate:sql8];
        if (!res) {
            NSLog(@"插入出错");
        }else{
            NSLog(@"插入成功");
            done(@"2");
        }
    }
    
}
+(void)selectDetailWithFinaplFinaPlpath:(NSString *)finalPath0 withDone:(doneWithObject)done{
    FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
    if ([billDB open]) {
        NSString *sql8 = @"SELECT  bill.*, (select type.title from type where type.id=bill.type_parent_id) as type_parent_name,(select type.title from type where bill.type_id=type.id) as type_name  FROM bill where bill.id<10 order time";
        FMResultSet *result = [billDB executeQuery:sql8];
        done(result);
        [billDB close];
    }else{
        NSLog(@"打开错误");
    }
}
+(void)selectDetailWithParentId:(NSString *)parentid FinaplFinaPlpath:(NSString *)finalPath0 withDone:(doneWithObject)done{
    FMDatabase *billDB = [FMDatabase databaseWithPath:finalPath0];
    if ([billDB open]) {
        NSString *sql8 =[NSString stringWithFormat:@"SELECT bill.*, (select type.title from type where type.id=bill.type_parent_id) as type_parent_name,(select type.title from type where bill.type_id=type.id) as type_name  FROM bill where bill.type_parent_id%@ order time",parentid];
        FMResultSet *result = [billDB executeQuery:sql8];
        done(result);
        [billDB close];
    }else{
        NSLog(@"打开错误");
    }
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6)
        return DEFAULT_VOID_COLOR;
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return DEFAULT_VOID_COLOR;
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
