//
//  UserCell.m
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import "UserCell.h"
#import "UserInfo.h"

@interface UserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInfo:(UserInfo *)info {
    _info = info;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:info.avatar_url] placeholderImage:PLACEHOLDERIMAGE options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.loginLabel.text = info.login;
}

@end
