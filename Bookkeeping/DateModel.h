//
//  DateModel.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-23.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "JSONModel.h"
@protocol DateModel_info <NSObject>
@end


@interface DateModel_info : JSONModel
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *mone;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,strong)NSString *typeName;
@property (nonatomic,strong)NSString *type_parent_Name;
@property (nonatomic,assign)NSInteger type_id;
@property (nonatomic,assign)NSInteger type_parent_id;
@end
@interface DateModel : JSONModel
@property(nonatomic,strong)NSMutableArray <DateModel_info>*info;
@end