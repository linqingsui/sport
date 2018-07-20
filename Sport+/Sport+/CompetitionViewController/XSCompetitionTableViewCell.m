//
//  XSCompetitionTableViewCell.m
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSCompetitionTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NSDate+YYAdd.h"


@implementation XSCompetitionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMatchesItemJsonModel:(XSMatchesItemJsonModel *)matchesItemJsonModel{
    self.label_leftScore.text=matchesItemJsonModel.matchInfo.leftGoal;
    self.label_rightScore.text=matchesItemJsonModel.matchInfo.rightGoal;
    [self.imageView_leftIcon sd_setImageWithURL:[[NSURL alloc] initWithString:matchesItemJsonModel.matchInfo.leftBadge] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    [self.imageView_rightIcon sd_setImageWithURL:[[NSURL alloc] initWithString:matchesItemJsonModel.matchInfo.rightBadge] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.label_comeinfo.text=[matchesItemJsonModel.matchInfo.broadcasters componentsJoinedByString:@" | "];
    
    switch ([matchesItemJsonModel.matchInfo.matchPeriod integerValue]) {
        case 0:
            self.label_status.text=@"未开始";
            break;
        case 1:
            self.label_status.text=@"直播中";
            break;
        case 2:
            self.label_status.text=@"已结束";
            break;
        default:
            break;
    }
    
    self.label_video.layer.cornerRadius=4;
    self.label_video.layer.borderColor=kFontColor.CGColor;
    self.label_video.layer.borderWidth=1;
    self.label_video.text=[[NSDate dateWithString:matchesItemJsonModel.matchInfo.startTime format:@"yyyy-MM-dd HH:mm:ss"] stringWithFormat:@"MM-dd HH:mm"];
    
    self.label_leftName.text=matchesItemJsonModel.matchInfo.leftName;
    self.label_rightName.text=matchesItemJsonModel.matchInfo.rightName;
}
@end
