//
//  GTMainViewController.m
//  qingcheng123
//
//  Created by Qidalatu on 14/10/24.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import "MainViewController.h"
#import "NewsViewController.h"
#import "AppDelegate.h"
#import "SlideNavigationController.h"
#import "MunuViewController.h"
#import "SharedData.h"
#import "LoginViewController.h"
#import "ShareAction.h"
#import "FMDB.h"
#import "ScollViewController.h"
#import "ButtonVIew.h"
#import "RemarkViewController.h"
#import "DetailCell.h"
#import "JSONModelLib.h"
#define width self.view.frame.size.width
#define height1 self.view.frame.size.height
@interface MainViewController () {
    AppDelegate *delegate;
    NSMutableArray *categoryList;
    ScollViewController*scollView;
    NSInteger columnCount;
    ButtonVIew *btnView;
    SharedData *sharedData;
    NSString *finalPath0;
    int k;
    int j;//0键盘隐藏状态，1键盘显示状态
}
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
   
    NSString *tmpPath = NSTemporaryDirectory();
     finalPath0 = [tmpPath stringByAppendingString:@"Bill.db"];
     sharedData = [SharedData sharedInstance];
    self.titleArray =[NSMutableArray new];
    self.data=[NSMutableArray new];
    [self.segment setTintColor:[ShareAction colorWithHexString:@"#FFCC99"]];
    self.segment.backgroundColor=[ShareAction colorWithHexString:@"#FFFFFF "];
    NSLog(@"%@",sharedData.loginStatus);
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([sharedData.loginStatus isEqualToString:@"YES"]) {
        LoginViewController *loginViewController=[storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    }else{
        NSLog(@"hahah");
    }
    [self.titleArray addObject:@"全部"];
    [ShareAction selectTitleWithParentid:@"0" andFinalPath:finalPath0 withDone:^(id result){
        NSLog(@"result:%@",result);
        while ([result next]) {
        int ID = [result intForColumn:@"id"];
        NSString *name = [result stringForColumn:@"title"];
        NSString *parent_id = [result stringForColumn:@"parent_id"];
        NSLog(@"%d %@ %@ ", ID, name,parent_id);
        [self.titleArray addObject:name];
        [self setTitle];
        }
    }];
     NSLog(@"loginname:%@",sharedData.loginname);
    if (![sharedData.loginname isEqualToString:@"YES"]) {
        scollView =[storyBoard instantiateViewControllerWithIdentifier:@"ScollViewController"];
        sharedData.loginname=@"YES";
        [self presentViewController:scollView animated:YES completion:nil];
    }
    delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    categoryList = [delegate arrCategories];
    MunuViewController *lMenu = (MunuViewController *)[SlideNavigationController sharedInstance].leftMenu;
    lMenu.delegate=self;
    self.title = NSLocalizedString(@"世如个个", nil);
    
    [super viewDidLoad];
}
-(void)viewWillAppear:(BOOL)animated{
    self.dataModel=[DateModel new];
    self.dataModel.info=(DateModel_info*)[NSMutableArray new];
    [ShareAction selectDetailWithFinaplFinaPlpath:finalPath0 withDone:^(id result){
        while ([result next]) {
            DateModel_info *model=[DateModel_info new];
            model.type_parent_Name = [result stringForColumn:@"type_parent_name"];
            model.typeName = [result stringForColumn:@"type_name"];
            model.time = [result stringForColumn:@"time"];
            model.address = [result stringForColumn:@"address"];
            model.mone = [result stringForColumn:@"money"];
            model.remark  = [result stringForColumn:@"remark"];
            [self.dataModel.info addObject:model];
        }
        NSLog(@"%@",self.dataModel);
        [self.tableView reloadData];
    }];

    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - SlideNavigationController Methods

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

-(void)pushLoginViewController{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController=[storyBoard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:YES completion:nil];
    
}
-(void)setTitle{
    btnView= [[ButtonVIew alloc] initWithFrame:CGRectMake(0, -180, width, 180)];
    btnView.backgroundColor = [UIColor whiteColor];
//    btnView.alpha=0.85;
    for (int i=0; i<self.titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn.layer setBorderWidth:0.5];
        [btn.layer setBorderColor:[ShareAction colorWithHexString:@"#FF9933"].CGColor];
        btn.titleLabel.font=[UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        [btn setTitle:self.titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[ShareAction colorWithHexString:@"#FF9933"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(NUmber:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        columnCount = 3;
        CGFloat appW=104.0;
        CGFloat appH=50.0;
        CGFloat appMargin=(width-columnCount*appW)/(columnCount+1);
        //计算列号和行号
        int colX=i%columnCount;
        int rowY=i/columnCount;
        //计算坐标
        CGFloat appX = appMargin+colX*(appW+appMargin);
        CGFloat appY = -150 + appH*rowY-10;
        btn.frame = CGRectMake(appX, appY+180, appW, 40);
        [btnView addSubview:btn];
    }
    [self.view addSubview:btnView];
}
- (IBAction)fenlei:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RemarkViewController *remarkViewController=[storyBoard instantiateViewControllerWithIdentifier:@"RemarkViewController"];
    [self.navigationController pushViewController:remarkViewController animated:YES];
}
-(void)keyboardUp{
    
    j=1;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    btnView.frame = CGRectMake(0,50, width, 180);
    [UIView commitAnimations];
}
-(void)keyboardDown
{
    j=0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    btnView.frame= CGRectMake(0, -180, width, 180);
    self.segment.selectedSegmentIndex=0;
    [UIView commitAnimations];
}
-(void)NUmber:(UIButton *)sender{
    NSInteger number =[sender tag];
    [self.segment setTitle:self.titleArray[number] forSegmentAtIndex:0];
    k=0;
    [self keyboardDown];
    self.dataModel=[DateModel new];
    self.dataModel.info=(DateModel_info*)[NSMutableArray new];
    NSString *numberStr;
    if (number==0) {
        numberStr=[NSString stringWithFormat:@""];
    }else{
        numberStr=[NSString stringWithFormat:@"=%ld",(long)number];
    }
    [ShareAction selectDetailWithParentId:numberStr FinaplFinaPlpath:finalPath0 withDone:^(id result){
        while ([result next]) {
            DateModel_info *model=[DateModel_info new];
            model.type_parent_Name = [result stringForColumn:@"type_parent_name"];
            model.typeName = [result stringForColumn:@"type_name"];
            model.time = [result stringForColumn:@"time"];
            model.address = [result stringForColumn:@"address"];
            model.mone = [result stringForColumn:@"money"];
            model.remark  = [result stringForColumn:@"remark"];
            model.type_id=[result intForColumn:@"type_id"];
            model.type_parent_id=[result intForColumn:@"type_parent_id"];
            [self.dataModel.info addObject:model];
        }
        NSLog(@"%@",self.dataModel);
        [self.tableView reloadData];
    }];
    NSLog(@"%ld",(long)number);
}
- (IBAction)seg:(UISegmentedControl *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    if (index==1) {
        if (k==0) {
            k=1;
            [self keyboardUp];
        }else{
            k=0;
            [self keyboardDown];
        }
    }else{
         k=0;
     [self keyboardDown];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.dataModel.info.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row =indexPath.row;
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    DateModel_info *model =self.dataModel.info[row];
    cell.time.text=model.time;
    cell.title.text=model.remark;
    cell.mone.text =model.mone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row==3) {
//        [self.delegate pushLoginViewController];
//    }else{
//        
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
@end
