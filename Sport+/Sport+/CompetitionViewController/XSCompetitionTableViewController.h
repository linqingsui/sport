//
//  XSCompetitionTableViewController.h
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSBaseTableViewController.h"
#import "XSMatchInfoJsonModel.h"
#import "ALButton.h"

@interface XSCompetitionTableViewController : XSBaseTableViewController
@property (weak, nonatomic) IBOutlet UIView *view_leftDate;
@property (weak, nonatomic) IBOutlet UIView *view_rightDate;
@property (weak, nonatomic) IBOutlet ALButton *btn_today;
@property (weak, nonatomic) IBOutlet UILabel *label_leftDate;
@property (weak, nonatomic) IBOutlet UILabel *label_rightDate;
@property (weak, nonatomic) IBOutlet UILabel *label_todayDate;

@end
