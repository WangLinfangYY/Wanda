//
//  WDHttpTool.h
//  WandaApp
//
//  Created by 王林芳 on 2017/11/14.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDHttpTool : NSObject

/**
 登录之外的所有接口  包含userId token 参数的请求 内部已经添加
 
 @param URLString  路径地址
 @param parameters  公用参数之外的参数
 @param block 数据回传
 */
+ (void)POST:(NSString *)URLString commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block;

//复杂类型
+ (void)POSTComplexStructure:(NSString *)URLString commonParameters:(id)parameters  block:(void (^)(NSInteger, XTRequestStatus, id))block;

/*!
 @method
 @abstract post请求
 @diXTussion post请求
 @param URLString  url
 @param parameters 参数
 @param timeInterval 超时时间
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
withTimeoutInterval:(NSTimeInterval)timeInterval
       block:(void(^)(NSInteger returnCode,XTRequestStatus status,id data))block;

/**
 post请求
 
 @param URLString 地址
 @param parameters 参数
 @param block 请求回调
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters dataBlock:(void(^)(NSInteger returnCode,XTRequestStatus status,id data))block;

/*!
 @method
 @abstract get请求
 @diXTussion get请求
 @param URLString  url
 @param parameters 参数
 
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
      block:(void(^)(NSInteger returnCode,XTRequestStatus status,id data))block;

/**
 上传公司logo图片
 
 @param URLString 地址
 @param image 图片
 @param parameters 参数
 @param block 回传信息
 */
+ (void)POSTCompanyPic:(NSString *)URLString  Image:(UIImage *)image commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block Progrss:(void (^) (NSProgress *  )  )Progress;

/**
 上传用户的头像
 
 @param URLString 地址
 @param image 图片
 @param parameters 参数
 @param block 回传信息
 */
+ (void)POSTUserPic:(NSString *)URLString  Image:(UIImage *)image commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress;

+ (void)POSTRecordFile:(NSString *)URLString  FileUrl:(NSURL *)fileUrl commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status ,id ))block   Progrss:(void (^) (NSProgress * )  )Progress;


+ (void)newColumn:(NSString *)URLString  photoDic:(NSDictionary *)photoDic commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress;

+ (void)POSTUID:(NSString *)URLString commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , XTRequestStatus status , id))block;


@end

