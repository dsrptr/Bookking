//
//  RemarkViewController.h
//  Bookkeeping
//
//  Created by MartinLi on 15-3-22.
//  Copyright (c) 2015年 Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "RMPickerViewController.h"
@interface RemarkViewController : UIViewController
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *backScroller;
@property (nonatomic,retain) RMPickerViewController *pickerVC;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *remark;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *mone;
@property (weak, nonatomic) IBOutlet UITextField *detail;
@property (weak, nonatomic) IBOutlet UITextField *cand;
- (IBAction)post:(id)sender;

@end
