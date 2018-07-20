//
//  HttpRequestManager.m
//  YWEdu
//
//  Created by zxw on 16/10/12.
//  Copyright © 2016年 zxw. All rights reserved.
//

#import "HttpRequestManager.h"
#import "AFHTTPSessionManager.h"

@implementation HttpRequestManager

+(void)startRequestWithBaseUrl:(NSString *)baseUrl CodeName:(NSString*)codeName parameters:(NSDictionary*)parameters progress:(void(^)(CGFloat progress))progress sucess:(void(^)(id responseObject))sucess failure:(void(^)(NSError *error))failure
{
    NSLog(@"%@请求参数%@",codeName,parameters);
    //Globals *globals = [Globals share];
//    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//    [securityPolicy setAllowInvalidCertificates:YES];
    
   // [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
   // [httpManager setSecurityPolicy:securityPolicy];
    httpManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    httpManager.responseSerializer = [AFJSONResponseSerializer serializer];

    httpManager.requestSerializer.timeoutInterval = 10;
    httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];
    
    NSString *realUrl = [NSString stringWithFormat:@"%@%@",baseUrl,codeName];
    [httpManager POST:realUrl parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      //  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (sucess)
        {
            sucess(responseObject);
        }
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      //  [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (failure)
        {
            failure(error);
        }
        NSLog(@"请求失败%@",error);
    }];
    

}

@end
