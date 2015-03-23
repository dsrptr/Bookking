//
//  ShareAction.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-4.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^doneWithObject)(id object);
@interface ShareAction : NSObject
+(void)createTabelwithFinalPath:(NSString *)finalPath0;
+(void)selectTitlewitFinalPath:(NSString *)finalPath0 withDone:(doneWithObject)done;

+(UIColor*)colorWithHexString:(NSString *)stringToConvert;
+(void)insertTitle:(NSString *)title andTypeId:(NSInteger )type_id andParentId:(NSInteger )parent_id andAddress:(NSString *)address andMone:(NSString *)mone andTime:(NSString *)time andRemark:(NSString *)remark andFinaPlpath:(NSString *)finalPath0 withDone:(doneWithObject)done;
+(void)selectDataWithTitle_id:(NSString *)title_id andandFinalPath:(NSString *)finalPath0 withDone:(doneWithObject)done;
+(void)selectTitleWithParentid:(NSString *)parent_id andFinalPath:(NSString *)finalPath0 withDone:(doneWithObject)done;
+(void)selectDetailWithFinaplFinaPlpath:(NSString *)finalPath0 withDone:(doneWithObject)done;
+(void)selectDetailWithParentId:(NSString *)parentid FinaplFinaPlpath:(NSString *)finalPath0 withDone:(doneWithObject)done;
@end
