//
//  UserDetailController.m
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import "UserDetailController.h"
#import "UserInfo.h"
#import "Report.h"

@interface UserDetailController ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;

@end

@implementation UserDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestUserDetailInfo];
}

#pragma mark - private
- (void)requestUserDetailInfo {
    [[NetworkManager sharedManager] requestWithMethod:GET URLString:self.userInfo.repos_url parameters:nil finishBlock:^(id result, NSError *error) {
        if (error) {
            DLog(@"%@", error);
            return;
        }
        [self performSelectorOnMainThread:@selector(updateUserInterface:) withObject:result waitUntilDone:YES];
    }];
}

- (void)updateUserInterface:(id)sender {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:self.userInfo.avatar_url] placeholderImage:PLACEHOLDERIMAGE options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.loginLabel.text = [NSString stringWithFormat:@"我是%@",self.userInfo.login];
    NSArray *reports = (NSArray *)sender;
    NSString *language = [Report reportPrefrenceLanguangWithArray:reports];
    self.languageLabel.text = [NSString stringWithFormat:@"我使用最多的语言是%@",language];
}

@end
