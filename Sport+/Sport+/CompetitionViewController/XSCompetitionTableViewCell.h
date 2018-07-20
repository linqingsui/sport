//
//  XSCompetitionTableViewCell.h
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XSMatchesItemJsonModel.h"

@interface XSCompetitionTableViewCell : UITableViewCell
@property (nonatomic) XSMatchesItemJsonModel *matchesItemJsonModel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_leftIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_leftScore;
@property (weak, nonatomic) IBOutlet UILabel *label_rightScore;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_rightIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_status;
@property (weak, nonatomic) IBOutlet UILabel *label_video;
@property (weak, nonatomic) IBOutlet UILabel *label_comeinfo;
@property (weak, nonatomic) IBOutlet UILabel *label_leftName;
@property (weak, nonatomic) IBOutlet UILabel *label_rightName;
@property (weak, nonatomic) IBOutlet UIImageView *imageView_foucs;

@end
