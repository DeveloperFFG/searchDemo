//
//  Report.h
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Report : NSObject

@property (nonatomic, copy) NSString *language;

// 字典转模型
+ (instancetype)reportWithDict:(NSDictionary *)dict;

// 处理数据,查找偏好语言
+ (NSString *)reportPrefrenceLanguangWithArray:(NSArray *)array;

@end
