//
//  MunuViewController.m
//  Bookkeeping
//
//  Created by macbook pro on 15/3/12.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import "MunuViewController.h"
#import "MenuCell.h"
#import "LoginViewController.h"
#import "MainViewController.h"
@interface MunuViewController ()

@end

@implementation MunuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self._tableView.tableFooterView =[UIView new];
    self._tableView.scrollEnabled=NO;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell" forIndexPath:indexPath];
    NSInteger row =indexPath.row;
    if (row==0) {
        cell.title.text=@"我的钱包";
    }else if (row==1) {
        cell.title.text=@"我的账单";
    }else if (row==2) {
        cell.title.text=@"我的收入";
    }else if (row==3) {
        cell.title.text=@"设置密码";
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==3) {
        [self.delegate pushLoginViewController];
    }else{
    
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
