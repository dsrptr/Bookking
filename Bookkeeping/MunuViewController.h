//
//  MunuViewController.h
//  Bookkeeping
//
//  Created by macbook pro on 15/3/12.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuDelegate <NSObject>
-(void)pushLoginViewController;
@end
@interface MunuViewController : UIViewController
@property (nonatomic,strong) id<MenuDelegate>delegate;
@property (retain, nonatomic) IBOutlet UITableView *_tableView;
@property (retain, nonatomic) IBOutlet UILabel *lb_nickName;
@property (retain, nonatomic) IBOutlet UIImageView *iv_Head;
@end
