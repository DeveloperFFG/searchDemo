//
//  Report.m
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import "Report.h"

@implementation Report

+ (instancetype)reportWithDict:(NSDictionary *)dict {
    Report *rep = [[self alloc] init];
    
    [rep setValuesForKeysWithDictionary:dict];
    return rep;
}

// 防止因找不到 key 而报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSString *)reportPrefrenceLanguangWithArray:(NSArray *)array {
    // 用于存放所有使用过的语言
    NSMutableArray *languageArrayM = [NSMutableArray arrayWithCapacity:5];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Report *report = [self reportWithDict:obj];
        if (report.language != nil) {
            [languageArrayM addObject:report.language];
        }
    }];
    
    // 把语言当做 key, 是用磁石当做 value,存放在字典中
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithCapacity:5];
    for (NSString *language in languageArrayM) {
        NSString *number = [dictM objectForKey:language];
        if (number == nil) {
            number = @"1";
        } else {
            number = [NSString stringWithFormat:@"%zd", number.intValue + 1];
        }
        [dictM setObject:number forKey:language];
    }
    
    // 存放偏好语言的字符串
    __block NSString *prefrenceStr;
    __block NSInteger times = 0;
    [dictM enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj integerValue] > times) {
            prefrenceStr = (NSString *)key;
            times = [obj integerValue];
        }
    }];
    
    return prefrenceStr;
}

@end
