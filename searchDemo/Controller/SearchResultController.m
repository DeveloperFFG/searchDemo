//
//  SearchResultController.m
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import "SearchResultController.h"
#import "UserDetailController.h"
#import "UserInfo.h"
#import "UserCell.h"

@interface SearchResultController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;
// 根据用户输入做一个标记,每次输入间隔小于0.5秒则取消本次请求
@property (nonatomic, assign) NSUInteger inputMark;
// 记录最后一次请求的关键字
@property (nonatomic, copy) NSString *lastSearchText;

@end

@implementation SearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestUserData:@{
                            @"q":@"test",
                            @"inputMark":@(self.inputMark)
                            }];
}

#pragma mark - private
- (void)requestUserData:(NSDictionary *)dict {
    if (self.inputMark == [dict[@"inputMark"] integerValue]) {
        NSString *searchText = [dict objectForKey:@"q"];
        // 本次请求关键字和上次一样,则取消本次请求
        if ([searchText isEqualToString:self.lastSearchText]) {
            return;
        }
        [[NetworkManager sharedManager] requestWithMethod:GET
                                                  URLString:[NSString stringWithFormat:@"%@search/users",SERVER_BASE_URL]
                                                 parameters:@{@"q":searchText}
                                                finishBlock:^(id result, NSError *error) {
                                                    if (error) {
                                                        DLog(@"%@",error);
                                                        // 可以显示提示框,提示请求失败原因...
                                                        return;
                                                    }
                                                    self.lastSearchText = searchText;
                                                    NSArray *items = [result objectForKey:@"items"];
                                                    self.dataSource = [UserInfo infoArrayWithResultArray:items].mutableCopy;
                                                    [self.tableView reloadData];
                                                }];
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"user_cell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    UserInfo *info = self.dataSource[indexPath.row];
    cell.info = info;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self requestUserData:@{
                            @"q":searchBar.text,
                            @"inputMark":@(self.inputMark)
                            }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
//    searchBar.text = @"";
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (IsEmpty(searchText)) {
//        self.dataSource = nil;
//        [self.tableView reloadData];
        return;
    }
    
    self.inputMark ++;
    [self performSelector:@selector(requestUserData:)
               withObject:@{
                            @"q":searchText,
                            @"inputMark":@(self.inputMark)
                            }
               afterDelay:0.5];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UserDetailController *detailVC = (UserDetailController *)segue.destinationViewController;
    UserCell *cell = (UserCell *)sender;
    
    detailVC.navigationItem.title = cell.info.login;
    detailVC.userInfo = cell.info;
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(nullable id)sender {
    UserCell *cell = (UserCell *)sender;
    if (IsEmpty(cell.info)) {
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

@end
