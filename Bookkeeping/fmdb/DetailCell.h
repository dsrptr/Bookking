//
//  DetailCell.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-23.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *mone;

@end
