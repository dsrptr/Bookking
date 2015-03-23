//
//  GTMainViewController.h
//  qingcheng123
//
//  Created by Qidalatu on 14/10/24.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ViewPagerController.h"
#import "SlideNavigationController.h"
#import "MunuViewController.h"
#import "EAIntroView.h"
#import "DateModel.h"
@interface MainViewController : ViewPagerController <SlideNavigationControllerDelegate,MenuDelegate>
- (IBAction)seg:(UISegmentedControl *)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *btView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property (nonatomic,strong)NSMutableArray *data;
@property (nonatomic,strong)DateModel *dataModel;
@end
