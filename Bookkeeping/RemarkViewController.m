 //
//  RemarkViewController.m
//  Bookkeeping
//
//  Created by MartinLi on 15-3-22.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "RemarkViewController.h"
#import "ShareAction.h"
#import "SharedData.h"
#import "FMDB.h"
#import "NString+NsDate.h"
@interface RemarkViewController ()<UITextFieldDelegate,RMPickerViewControllerDelegate>
{
//    int count;
    NSMutableArray *titleArray;//标题数组
    NSMutableArray *titleIdarray;//标题id数组 也就是分类
    NSString *finalPath0;//数据库地址
    NSInteger type;//区分pick用的
    NSInteger parents_id;//查询的parents_id
    NSInteger type_id;//查询的type_id
    NSArray *yearArray;//年数组
    NSMutableArray *mouthArray;//月数组
    NSMutableArray *dayArray;//日数组
    NSInteger month;//当前月
    NSInteger day;//当前日
    NSInteger year;//当前年
    NSInteger type2;//有个默认选中得状态
    NSInteger pickType;//pickview的样式
    
    
    
}
@property(nonatomic,strong)NSString *__day;
@property(nonatomic,strong)NSString *__type;
@property(nonatomic,strong)NSString *__dtype2;
@property(nonatomic,strong)NSString *__remark;
@property(nonatomic,strong)NSMutableArray *components;
@end

@implementation RemarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    mouthArray =[NSMutableArray new];
    dayArray=[NSMutableArray new];
    NSString *tmpPath = NSTemporaryDirectory();
    finalPath0= [tmpPath stringByAppendingString:@"Bill.db"];
    self.cand.keyboardType=UIKeyboardTypeDefault;
   
    SharedData *shareData =[SharedData sharedInstance];
    NSLog(@"%@",shareData.loginname);
    type =0;
   
    NSDate *date =[NSDate date];
    
    NSDateComponents *dateComponents =[NString_NsDate YMDComponentswitDate:date];
    NSInteger str =dateComponents.year;
    day =dateComponents.day-1;
    month =dateComponents.month-1;
    NSString *str1=[NSString stringWithFormat:@"%ld",(long)str-1];
    NSString *str2=[NSString stringWithFormat:@"%ld",(long)str];
    NSString *str3=[NSString stringWithFormat:@"%ld",(long)str+1];
    
    yearArray=@[str1,str2,str3];
    for (int i=0; i<12; i++) {
        [mouthArray addObject:[NSString stringWithFormat:@"%d",i+1]];
    }
    for (int j=0; j<[NString_NsDate numberOfDaysInCurrentMonthwitDate:date]; j++) {
        [dayArray addObject:[NSString stringWithFormat:@"%d",j+1]];
    }
    
    self.backScroller.backgroundColor=[ShareAction colorWithHexString:@"#FF9999 "];
    self.backScroller.autoresizesSubviews=YES;
    [self.navigationItem.leftBarButtonItem setTitle:@""];
    self.textView.layer.cornerRadius=5;
    self.remark.titleLabel.font =[UIFont fontWithName:@"STHeiti J" size:15];
    self.remark.tintColor=[ShareAction colorWithHexString:@"#ffffff"];
    // Do any additional setup after loading the view.
}

-(void)selectTitleWithparentId:(NSString *)parent_id{
    titleArray =[NSMutableArray new];
    titleIdarray=[NSMutableArray new];
    [ShareAction selectTitleWithParentid:parent_id andFinalPath:finalPath0 withDone:^(id result){
        while ([result next]) {
            int ID = [result intForColumn:@"id"];
            NSString *name = [result stringForColumn:@"title"];
            NSString *parent_id = [result stringForColumn:@"parent_id"];
            NSLog(@"%d %@ %@ ", ID, name,parent_id);
            [titleArray addObject:name];
            [titleIdarray addObject:[NSString stringWithFormat:@"%d",ID]];
        }
        [self setPickwithDatas:titleArray];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
   
}

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
     type2=0;
    if (textField.tag==2) {
        [textField resignFirstResponder];
        textField.keyboardType=UIKeyboardTypeNumberPad;
        return YES;
    }else if(textField.tag==3){
        [textField resignFirstResponder];
        return YES;
    } else{
        if (textField.tag==0) {
        pickType=0;
        type=1;
        [self selectTitleWithparentId:@"0"];
    }else if (textField.tag==1) {
        pickType=1;
        type=2;
        [self selectTitleWithparentId:[NSString stringWithFormat:@"%ld",(long)parents_id]];
    }else if(textField.tag==4){
        pickType=4;
        type=3;
        [self setPickwithDatas:yearArray];
        
    }
    NSLog(@"%ld",(long)textField.tag);
//    type2=1;
    return NO;
    }
   
}
-(void)setPickwithDatas:(NSArray *)datas{
    self.pickerVC = [RMPickerViewController pickerController];
//    count = (int)datas.count;
    self.pickerVC.delegate = self;
    self.pickerVC.titleLabel.text = @"选择";
    self.pickerVC.disableBlurEffects = YES;
    [self.pickerVC show];
}
#pragma mark - RMPickerViewController Delegates
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (pickType==0||pickType==1) {
        return 1;
    }else{
     return 3;
    }
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickType==0||pickType==1) {
        return titleArray.count;
    }else{
    if (component==0) {
        return yearArray.count;
    }else if(component==1){
        return mouthArray.count;
    }else if(component==2){
        return dayArray.count;
    }else{
        return 0;
    }
 }
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickType==0||pickType==1) {
        return titleArray[row];
    }else{
        if (component==0) {
            if (type2==1) {
            }else{
                [pickerView selectRow:1 inComponent:0 animated:YES];
            }
            return yearArray[row];
        }else if (component==1) {
            if (type2==1) {
            }else{
                [pickerView selectRow:month inComponent:1 animated:YES];
            }
            return mouthArray[row];
        }else{
            if (type2==1) {
            }else{
//                [pickerView selectRow:day inComponent:2 animated:YES];
            }
            return dayArray[row];
        }
    }
}

- (void)pickerViewController:(RMPickerViewController *)vc didSelectRows:(NSArray *)selectedRows {
    if (pickType==0||pickType==1) {
        NSString *value = titleArray[[selectedRows[0] integerValue]];
        NSLog(@"%@",titleIdarray);
        NSString *title_id =titleIdarray[[selectedRows[0] integerValue]];;
        if (type==1) {
            self.cand.text=value;
            parents_id= [title_id integerValue];
            type=2;
            NSLog(@"%@",title_id);
            [self selectTitleWithparentId:title_id];
        }else if (type==2) {
            type_id=[title_id integerValue];
            self.detail.text=value;
        }
    }else{
        NSString *value1 =[NSString stringWithFormat:@"%@-%@-%@",yearArray[[selectedRows[0]integerValue]],mouthArray[[selectedRows[1]integerValue]],dayArray[[selectedRows[2]integerValue]]];
        NSLog(@"%@",value1);
        self.time.text=value1;
        self.__day=value1;
//        NSDate *date1 =[NString_NsDate dateFromString:value1];
//        NSLog(@"%@",date1);
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
//    if (pickType==0||pickType==1) {
//        NSLog(@"%@",titleIdarray);
//        if (type==1) {
//            self.cand.text=titleArray[row];
//            parents_id= [titleIdarray[row] integerValue];
//            type=2;
//            NSLog(@"%ld",(long)parents_id);
//            [self selectTitleWithparentId:[NSString stringWithFormat:@"%ld",(long)parents_id]];
//        }else if (type==2) {
////            type_id=titleIdarray[row];
//            self.detail.text=titleArray[row];
//        }else{
//        
//        }
//    }else{
//        NSString *value1 =[NSString stringWithFormat:@"%@-%@-%@",yearArray[[selectedRows[0]integerValue]],mouthArray[[selectedRows[1]integerValue]],dayArray[[selectedRows[2]integerValue]]];
//        NSLog(@"%@",value1);
//        self.time.text=value1;
//        self.__day=value1;
//        //        NSDate *date1 =[NString_NsDate dateFromString:value1];
//        //        NSLog(@"%@",date1);
//    }

    type2=1;
    NSLog(@"%ld",(long)row);
}
//-(NSString *)valueFromSelectedRows:(NSArray *)selectedRows andComponents:(NSArray *)components{
//    if (pickType==0||pickType==1) {
//        NSString *value =[]
//    }
//    NSLog(@"%@",selectedRows);
//    NSLog(@"%@",components);
//    NSMutableString *value = [[NSMutableString alloc] init];
//    for (int k=0; k<selectedRows.count;k++) {
//        NSString *value = components[k];
//        return value;
//    }
//    return value;
//}


- (IBAction)post:(id)sender {
    [ShareAction insertTitle:@"" andTypeId:type_id andParentId:parents_id andAddress:self.address.text andMone:self.mone.text andTime:self.__day andRemark:self.textView.text andFinaPlpath:finalPath0 withDone:^(NSString *result){
        if ([result isEqualToString:@"2"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    
}
@end
