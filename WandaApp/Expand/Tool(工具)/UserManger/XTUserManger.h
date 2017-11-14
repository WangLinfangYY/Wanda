//
//  UserManger.h
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/12.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTBaseModel.h"
#import "XTUserModel.h"
@interface XTUserManger : XTBaseModel



/**
 维护用户模型的工具类

 @return 自己的对象
 */
+ (instancetype)shareXTUserManger;



/**
 用户模型
 */
@property (nonatomic,strong) XTUserModel*  userModel;


/**
 清除用户模型的数据 但是保留用户模型的手机号码
 */
+ (void)clearUserModel;


/**
 信息id    新建受访信息单位信息传值
 */
@property (nonatomic,copy) NSString * informationId;

/**
 所属受访公司标识  新建受访信息项目信息传值
 */
@property (nonatomic,copy) NSString * comId;



//////////////////////////////打开相册的公用方法

- (void)startSelectSysPic;

@property (nonatomic,strong) void (^imageBlock)(UIImage *image);


/**
 微信分享的 Url
 */
@property (nonatomic,copy) NSString * linkUrl;
//微信分享的发送URL
- (void) sendLinkContentUrl:(NSString *)url;


@end
