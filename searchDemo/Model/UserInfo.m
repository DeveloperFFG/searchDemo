//
//  UserInfo.m
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (instancetype)infoWithDict:(NSDictionary *)dict {
    UserInfo *userinfo = [[self alloc] init];
    
    [userinfo setValuesForKeysWithDictionary:dict];
    return userinfo;
}

// 由于模型中的属性比返回的数据字典中的key数量少,为防止因找不到key而报错,需要实现此方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSArray *)infoArrayWithResultArray:(NSArray *)array {
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:10];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [arrayM addObject:[self infoWithDict:obj]];
    }];
    return arrayM.copy;
}

@end
