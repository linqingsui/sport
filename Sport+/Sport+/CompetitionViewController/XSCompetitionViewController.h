//
//  XSCompetitionViewController.h
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSBaseViewController.h"
#import "ALButton.h"

@interface XSCompetitionViewController : XSBaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet ALButton *btn_one;
@property (weak, nonatomic) IBOutlet ALButton *btn_two;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *btn_search;
@property (strong,nonatomic) NSString *selectedNumber;
@property (weak, nonatomic) IBOutlet UIView *view_one;
@property (weak, nonatomic) IBOutlet UIView *view_two;
@end
