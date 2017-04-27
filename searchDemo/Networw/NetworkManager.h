//
//  NetworkManager.h
//  searchDemo
//
//  Created by GuanFeng on 2017/4/27.
//  Copyright © 2017年 GuanFeng. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    GET,
    POST
}GFRequestMethod;

@interface NetworkManager : AFHTTPSessionManager

// 网络请求单利
+ (instancetype)sharedManager;

// 封装请求数据的方法
- (void)requestWithMethod:(GFRequestMethod)method URLString:(NSString *)URLString parameters:(id)parameters finishBlock:(void (^)(id result, NSError *error))finished;

@end
