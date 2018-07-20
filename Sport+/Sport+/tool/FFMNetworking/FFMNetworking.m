//
//  FFMNetworking.m
//  AppModule
//
//  Created by wujiangwei on 14-9-22.
//  Copyright (c) 2014年 Kevin. All rights reserved.
//

#import "FFMNetworking.h"

NSString *const kNetworkDataParseErrorDomain = @"FFMNetworking.JSON.PARSE.ERROR";

static FFMNetworking *__helper = nil;

@interface FFMNetworking()
{
    BOOL _isOpenLogger;
}

@end

@implementation FFMNetworking

#pragma mark - handler

//need Override this method
+ (NSString *)baseUrl
{
    return nil;
}

+ (instancetype)defaultNetClient{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __helper = [[self alloc] initWithBaseURL:[NSURL URLWithString:[[self class] baseUrl]]];
        [__helper setLogger:YES];
        [__helper addresponseSerializerContentTypes:@"text/html"];
    });
    return __helper;
}

#pragma mark - Debugger Tools

- (void)setLogger:(BOOL)loggerSwitch
{
    _isOpenLogger = loggerSwitch;
}

- (void)reloadHttpClientWithBaseURL:(NSString *)aURL {
    __helper = [[FFMNetworking alloc] initWithBaseURL:[NSURL URLWithString:aURL]];
}

#pragma mark - Http GET and POST

#pragma mark - GET

- (NSURLSessionTask *)GET:(NSString *)urlPath
                          param:(NSDictionary *)params
                 JSONModelClass:(Class)responseModelClass
                        success:(BlockHTTPRequestSuccess)success
                        failure:(BlockHTTPRequestFailure)failure
{
    NSURL *fullUrl = [NSURL URLWithString:urlPath relativeToURL:self.baseURL];
    return [self sendRequestForURL:fullUrl httpMethod:@"GET" responseModelClass:responseModelClass withParameters:params success:success failure:failure];
}

- (NSURLSessionTask *)GETRModel:(ModelRequestJsonModel *)aModel
                 JSONModelClass:(Class)responseModelClass
                        success:(BlockHTTPRequestSuccess)success
                        failure:(BlockHTTPRequestFailure)failure
{
    NSURL *fullUrl = [NSURL URLWithString:aModel.urlPath relativeToURL:self.baseURL];
    return [self sendRequestForURL:fullUrl httpMethod:@"GET" responseModelClass:responseModelClass withParameters:[aModel toDictionary] success:success failure:failure];
}

#pragma mark - POST

- (NSURLSessionTask *)POST:(NSString *)urlPath
                            param:(NSDictionary *)params
                  JSONModelClass:(Class)responseModelClass
                         success:(BlockHTTPRequestSuccess)success
                         failure:(BlockHTTPRequestFailure)failure
{
    
    NSURL *fullUrl = [NSURL URLWithString:urlPath relativeToURL:self.baseURL];
    return [self sendRequestForURL:fullUrl httpMethod:@"POST" responseModelClass:responseModelClass withParameters:params success:success failure:failure];
}

- (NSURLSessionTask *)POSTRModel:(ModelRequestJsonModel *)aModel
                  JSONModelClass:(Class)responseModelClass
                         success:(BlockHTTPRequestSuccess)success
                         failure:(BlockHTTPRequestFailure)failure
{
    NSURL *fullUrl = [NSURL URLWithString:aModel.urlPath relativeToURL:self.baseURL];
    return [self sendRequestForURL:fullUrl httpMethod:@"POST" responseModelClass:responseModelClass withParameters:[aModel toDictionary] success:success failure:failure];
}

#pragma mark - POST Upload progress and POST Form Data

- (NSURLSessionTask *)POST:(ModelRequestJsonModel *)aModel
                           param:(NSDictionary *)params
                  JSONModelClass:(Class)responseModelClass
                  uploadProgress:(BlockHTTPRequestUploadProgress)uploadProgress
                downloadProgress:(BlockHTTPRequestDownloadProgress)downloadProgress
                         success:(BlockHTTPRequestSuccess)success
                         failure:(BlockHTTPRequestFailure)failure
{
    NSAssert(0, @"do not support now");
    return nil;
}

- (NSURLSessionTask *)POSTRModel:(ModelRequestJsonModel *)aModel
                        JSONModelClass:(Class)responseModelClass
                        uploadProgress:(BlockHTTPRequestUploadProgress)uploadProgress
                      downloadProgress:(BlockHTTPRequestDownloadProgress)downloadProgress
                               success:(BlockHTTPRequestSuccess)success
                               failure:(BlockHTTPRequestFailure)failure
{
    NSAssert(0, @"do not support now");
    return nil;
}

//上传Form 表单
- (NSURLSessionTask *)POST:(ModelRequestJsonModel *)aModel
                    WithFormData:(NSData *)data
                  JSONModelClass:(Class)responseModelClass
                  uploadProgress:(BlockHTTPRequestUploadProgress)uploadProgress
                downloadProgress:(BlockHTTPRequestDownloadProgress)downloadProgress
                         success:(BlockHTTPRequestSuccess)success
                         failure:(BlockHTTPRequestFailure)failure
{
    NSAssert(0, @"do not support now");
    return nil;
}

- (NSURLSessionTask *)POSTRModel:(ModelRequestJsonModel *)aModel
                          WithFormData:(NSData *)data
                        JSONModelClass:(Class)responseModelClass
                        uploadProgress:(BlockHTTPRequestUploadProgress)uploadProgress
                      downloadProgress:(BlockHTTPRequestDownloadProgress)downloadProgress
                               success:(BlockHTTPRequestSuccess)success
                               failure:(BlockHTTPRequestFailure)failure
{
    NSAssert(0, @"do not support now");
    return nil;
}

#pragma mark - Http with cache

/**
 *  封装的POST请求
 *
 *  @param aModel             请求和参数Model
 *  @param responseModelClass 解析的JSONModel
 *  @param cachePolicy        缓存策略
 *  @param onCache            获取缓存回调
 *  @param success            成功回调
 *  @param failure            失败回调
 *
 *  @return 已发送的request 可以为nil
 */
- (NSURLSessionTask *)POST:(ModelRequestJsonModel *)aModel
                  JSONModelClass:(Class)responseModelClass
                 withCachePolicy:(eURLCachePolicy)cachePolicy
                         onCache:(BlockHTTPRequestCache)onCache
                         success:(BlockHTTPRequestSuccess)success
                         failure:(BlockHTTPRequestFailure)failure
{
    NSAssert(0, @"do not support now");
    return nil;
}

/**
 *  封装的GET请求
 *
 *  @param aModel             请求和参数Model
 *  @param responseModelClass 解析的JSONModel
 *  @param cachePolicy        缓存策略
 *  @param onCache            获取缓存回调
 *  @param success            成功回调
 *  @param failure            失败回调
 *
 *  @return 已发送的request 可以为nil
 */
- (NSURLSessionTask *)GET:(ModelRequestJsonModel *)aModel
                 JSONModelClass:(Class)responseModelClass
                withCachePolicy:(eURLCachePolicy)cachePolicy
                        onCache:(BlockHTTPRequestCache)onCache
                        success:(BlockHTTPRequestSuccess)success
                        failure:(BlockHTTPRequestFailure)failure
{
    NSAssert(0, @"do not support now");
    return nil;
}

#pragma mark - 基础Http请求

- (NSURLSessionTask *)sendRequestForURL:(NSURL *)aURL httpMethod:(NSString *)httpMethod responseModelClass:(Class)responseModelClass withParameters:(NSDictionary *)parameters success:(BlockHTTPRequestSuccess)success failure:(BlockHTTPRequestFailure)failure
{
    //部分设置
   // AFHTTPSessionManager *httpManager = [AFHTTPSessionManager manager];
    // [httpManager setSecurityPolicy:securityPolicy];
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    self.requestSerializer.timeoutInterval = 10;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", @"text/plain", nil];

    
    
    //Add public HTTP params
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    NSDictionary *commonParam = [self commonRequestParam];
    [dictionary addEntriesFromDictionary:commonParam];
    //相同key会用户参数会覆盖公共参数
    [dictionary addEntriesFromDictionary:parameters];
    
    NSError *reError = nil;

    NSAssert(reError == nil, @"get request error:Url = %@ Method = %@ param = %@", aURL, httpMethod, parameters);
    NSLog(@":Url = %@ Method = %@ param = %@", aURL, httpMethod, parameters);

//    NSURLSessionTask *operation = [self dataTaskWithHTTPMethod:httpMethod URLString:[aURL absoluteString] parameters:dictionary uploadProgress:nil downloadProgress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSError *error;
//        ModelResponseJsonModel *responseModel = [FFMNetworking JSONModelFromResponseDictionary:[FFMNetworking dictionaryFromResponseData:responseObject] withJSONModelClass:responseModelClass error:&error];
//        if (error == nil && success && responseModelClass != nil) {
//            NSLog(@"%@",responseModel);
//            success(operation, responseModel);
//        }else{
//            failure(operation, error);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        if (failure) {
//            failure(operation, error);
//        }
//    }];

    __block NSURLSessionTask *operation=[self HTTPMethod:httpMethod URLString:[aURL absoluteString] parameters:dictionary
    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        ModelResponseJsonModel *responseModel = [FFMNetworking JSONModelFromResponseDictionary:[FFMNetworking dictionaryFromResponseData:responseObject] withJSONModelClass:responseModelClass error:&error];
        if (error == nil && success && responseModelClass != nil) {
            NSLog(@"%@",responseModel);
            success(operation, responseModel);
        }else{
            failure(operation, error);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(operation, error);
        }
    }];
    return operation;
}

#pragma mark - Override Method

- (NSDictionary *)commonRequestParam
{
    //Base Class Method do nothing
    //Like Timestamps
        //[dictionary setObject:[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000] forKey:@"timestamp"];
    return nil;
}

+ (NSDictionary *)willParseDicToJSONModel:(NSDictionary *)netDic
{
//    JSONModel *json=[[JSONModel alloc]initWithDictionary:netDic error:nil];
//    NSMutableString *string=[[NSMutableString alloc]initWithString:[json toJSONString]];
//    [string stringByReplacingOccurrencesOfString:@"\"id\":\"" withString:@"\"myId\":\""];
    //Base Class Method do nothing
    return netDic;
}

- (void)ignoreCacheCommonParam:(NSDictionary *)ignoreCommonDic;
{
    //Base Class Method do nothing
    return;
}

#pragma mark - Model Network Client Support Service data

+ (BOOL)isClassTypeSupport:(id)checkData
{
    if ([checkData isKindOfClass:[NSData class]] ||
        [checkData isKindOfClass:[NSDictionary class]] ||
        [checkData isKindOfClass:[NSArray class]]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - Model Network Client Tools

+ (NSDictionary *)dictionaryFromResponseData:(id)responseData {
    
    if ([FFMNetworking isClassTypeSupport:responseData] == NO) {
        return nil;
    }
    
    if ([responseData isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:responseData options:0 error:NULL];
    }
    
    if ([responseData isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)responseData;
    }
    
    if ([responseData isKindOfClass:[NSArray class]]) {
        NSMutableDictionary *mDic = [[NSMutableDictionary alloc] initWithCapacity:1];
        [mDic setObject:responseData forKey:kModelNetworkDefaultArrayKey];
        return mDic;
    }
    
    return nil;
}

+ (ModelResponseJsonModel *)JSONModelFromResponseDictionary:(NSDictionary *)dictionary
                                   withJSONModelClass:(Class)JSONModelClass
                                                error:(NSError **)error {
    
    ModelResponseJsonModel *aModel = nil;
    
    @try
    {
        //如何需要特殊处理服务器返回的数据结构，在此处处理
        NSDictionary *dealedDic = [FFMNetworking willParseDicToJSONModel:dictionary];
        
        aModel = [(ModelResponseJsonModel *)[JSONModelClass alloc] initWithDictionary:dealedDic error:error];
    }
    @catch (NSException *exception) {
        *error = [NSError errorWithDomain:kNetworkDataParseErrorDomain
                                     code:NetworkAPIHelperErrorCodeModelParse
                                 userInfo:@{
                                            NSLocalizedDescriptionKey: @"JSONModel解析错误[数据类型不匹配]"
                                            }];
    }
    @finally {
    }
    
    return aModel;
}

- (void)addresponseSerializerContentTypes:(NSString *)contentType
{
    NSMutableSet *nSet = [NSMutableSet setWithSet:self.responseSerializer.acceptableContentTypes];
    [nSet addObject:contentType];
    [self.responseSerializer setAcceptableContentTypes:nSet];
}

#pragma mark - Http Cache Module

- (NSString *)urlMD5
{
    return nil;
}

- (void)cacheResponse:(NSDictionary *)responseDic
{
    //
}

- (NSDictionary *)readResponse:(NSURLRequest *)urlRequest
{
    [urlRequest.URL absoluteString];
    return nil;
}

@end

#pragma mark - Base Request Model and Response Model

#pragma mark - Request Model

@implementation ModelRequestJsonModel

- (id)initWithURLPath:(NSString *)ap
{
    self = [super init];
    if (self != nil) {
        self.urlPath = ap;
    }
    
    return self;
}

@end

#pragma mark - Response Model

@implementation ModelResponseJsonModel

@end
