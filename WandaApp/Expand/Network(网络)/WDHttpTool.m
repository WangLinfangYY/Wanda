//
//  WDHttpTool.m
//  WandaApp
//
//  Created by 王林芳 on 2017/11/14.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import "WDHttpTool.h"

@implementation WDHttpTool

+ (AFHTTPSessionManager *)configManger{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 1.初始化单例类
    //    manager.securityPolicy.SSLPinningMode = AFSSLPinningModeCertificate;
    // 2.设置证书模式
    //    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
    //    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
    //    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
    //    // 客户端是否信任非法证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.requestSerializer.timeoutInterval = XTTimeOutInterval;
    
    return  manager;
}


+ (void)POSTUID:(NSString *)URLString commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"uid"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    [self POST:URLString parameters:mutableDic block:^(NSInteger returnCode, XTRequestStatus status, id data) {
        
        if (status == XTRequestStatusOK) {
            
            
        }
        if (block) {
            
            block(returnCode,status,data);
        }
    }];
}




+ (void)POST:(NSString *)URLString commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"userId"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    [self POST:URLString parameters:mutableDic block:^(NSInteger returnCode, XTRequestStatus status, id data) {
        
        if (status == XTRequestStatusOK) {
            
            
        }
        if (block) {
            
            block(returnCode,status,data);
        }
    }];
}


+ (void)POST:(NSString *)URLString parameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block
{
    
    [self POST:URLString parameters:parameters block:^(NSInteger returnCode, XTRequestStatus status, id data) {
        
        if (status == XTRequestStatusOK) {
            
        }
        
        if (block) {
            PLog(@"%@",data);
            block(returnCode,status,data);
        }
    }];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters block:(void (^)(NSInteger , XTRequestStatus, id))block
{
    [self POST:URLString parameters:parameters withTimeoutInterval:XTTimeOutInterval block:block];
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters withTimeoutInterval:(NSTimeInterval)timeInterval block:(void (^)(NSInteger, XTRequestStatus, id))block
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = timeInterval;
    
    //生成新的默认
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //默认的类型
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    NSDictionary *dataDic = (NSDictionary *)parameters;
    
    
    [manager POST:UrlString parameters:dataDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
    }];
}




/**
 上传公司logo图片
 
 @param URLString 地址
 @param image 图片
 @param parameters 参数
 @param block 回传信息
 */
+ (void)POSTCompanyPic:(NSString *)URLString  Image:(UIImage *)image commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"userId"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //默认的类型
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 60;
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [NSString getUuid]];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    [manager POST:UrlString parameters:mutableDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
        
    }];
}





/**
 上传用户的头像
 
 @param URLString 地址
 @param image 图片
 @param parameters 参数
 @param block 回传信息
 */
+ (void)POSTUserPic:(NSString *)URLString  Image:(UIImage *)image commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"userId"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 60;
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [NSString getUuid]];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    [manager POST:UrlString parameters:mutableDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
        
    }];
}



+ (void)POSTComplexStructure:(NSString *)URLString commonParameters:(id)parameters  block:(void (^)(NSInteger, XTRequestStatus, id))block
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = XTTimeOutInterval;
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer  setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"userId"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    
    
    [manager POST:UrlString parameters:mutableDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self responseError:error block:block];
        
    }];
}



+ (void)GET:(NSString *)URLString parameters:(id)parameters block:(void(^)(NSInteger,XTRequestStatus,id))block
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    NSDictionary *dataDic = (NSDictionary *)parameters;
    
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"userId"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    
    
    [manager GET:UrlString parameters:mutableDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self responseError:error block:block];
    }];
}


+ (void)responseSuccess:(id)responseObject block:(void (^)(NSInteger, XTRequestStatus, id))block
{
    XTRequestStatus status = XTRequestStatusError;
    
    NSDictionary *data = nil;
    
    NSDictionary *dictionary =  [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    BOOL  sucess = [[dictionary valueForKey:@"success"] integerValue];
    NSInteger  code = [[dictionary valueForKey:@"errorCode"] integerValue];
    NSString *msg = [dictionary valueForKey:@"msg"];
    
    if (sucess) {
        
        status = XTRequestStatusOK;
        
        data = [dictionary valueForKey:@"value"];
        
    }else{
        
        if(msg != nil){
            [SCMessageHelper showAutoMessage:msg];
        }else{
            [SCMessageHelper showAutoMessage:@"服务器提示nil"];
        }
        
        //做出相应的处理
        if(code == 95999 || code == 95998){
            
            [XTUserManger clearUserModel];
//
            [SVProgressHUD showWithStatus:msg];
            [SVProgressHUD dismissWithDelay:0.8];
        }
        
    }
    if (block) {
        
        block(code,status,data);
    }
    
}
+ (void)responseError:(NSError *)error block:(void (^)(NSInteger, XTRequestStatus, id))block
{
    NSInteger errorCode = 999;
    
    if (    [[AFNetworkReachabilityManager sharedManager] isReachable] == NO) {
        errorCode = 998;
        [SCMessageHelper showAutoMessage:@"网络已断开，请检查网络"];
    }else{
        [SCMessageHelper showAutoMessage:@"服务器未连接"];
    }
    
    if (block) {
        block(errorCode,XTRequestStatusError,error);
    }
}




+ (void)newColumn:(NSString *)URLString  photoDic:(NSDictionary *)photoDic commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress
{
    
    
    
    ColumnModel *model = parameters;
    if (model.id == nil) {
        model.id = @"";
    }
    NSDictionary *dic =@{
                         @"id":model.id,
                         @"title":model.title,
                         @"summary":model.summary,
                         @"url":model.url,
                         @"name":model.name,
                         @"idCard":model.idCard,
                         @"number":model.number,
                         @"email":model.email,
                         @"status":model.status
                         };
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.id  forKey:@"userId"];
    [mutableDic setValue:XTUserMangerShareXTUserManger.userModel.token  forKey:@"token"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //默认的类型
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 60;
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",XTAppBaseURL,URLString];
    
    
    //    NSString *fileName = [NSString stringWithFormat:@"%@.png", [NSString getUuid]];
    
    [manager POST:UrlString parameters:mutableDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
        NSData *data;
        
        for (NSString *key in [photoDic allKeys]){
            
            UIImage *image =  photoDic[key];
            
            if (UIImagePNGRepresentation(image) == nil) {
                data = UIImageJPEGRepresentation(image, 1.0);
            } else {
                data = UIImagePNGRepresentation(image);
            }
            
            //上传文件参数
            [formData appendPartWithFileData:data name:key fileName:photoDic[key] mimeType:@"image/jpeg"];
        }
        // 上传文件
        //        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
        
    }];
}

@end
