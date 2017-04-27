//
//  Macros.h
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

// baseURL
#define SERVER_BASE_URL @"https://api.github.com/"

// 占位头像
#define PLACEHOLDERIMAGE [UIImage imageNamed:@"user_default_avatar"]

// debug 模式下打印
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// 判断是否为空
static inline BOOL IsEmpty(id thing) {
    return thing == nil || [thing isEqual:[NSNull null]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

#endif /* Macros_h */
