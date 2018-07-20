//
//  HttpRequestManager.h
//  YWEdu
//
//  Created by zxw on 16/10/12.
//  Copyright © 2016年 zxw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HttpRequestManager : NSObject
/**
 *  网络请求
 *
 *  @param codeName   接口名称
 *  @param parameters 参数（字典形式）
 *  @param progress   进度
 *  @param sucess     请求成功
 *  @param failure    请求失败
 */
+(void)startRequestWithBaseUrl:(NSString *)baseUrl CodeName:(NSString*)codeName parameters:(NSDictionary*)parameters progress:(void(^)(CGFloat progress))progress sucess:(void(^)(id responseObject))sucess failure:(void(^)(NSError *error))failure;

@end
