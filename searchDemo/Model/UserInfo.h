//
//  UserInfo.h
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, copy) NSString *login;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *repos_url;

// 把字典转换成模型
+ (instancetype)infoWithDict:(NSDictionary *)dict;

// 把返回的字典数组,转换成模型数组
+ (NSArray *)infoArrayWithResultArray:(NSArray *)array;

@end
