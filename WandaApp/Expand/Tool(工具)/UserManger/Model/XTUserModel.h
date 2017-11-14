//
//  XTUserModel.h
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/12.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "XTBaseModel.h"

@interface XTUserModel : XTBaseModel

/**
 用户id
 */
@property (nonatomic,copy) NSString * id;

/**
 用户账户
 */
@property (nonatomic,copy) NSString * phone;


/**
 真实名称
 */
@property (nonatomic,copy) NSString * name;


/**
 签名备注
 */
@property (nonatomic,copy) NSString * remark;


/**
 地址id
 */
@property (nonatomic,copy) NSString * location;

/**
 图片id
 */
@property (nonatomic,copy) NSString * photo;


/**
 最后登录时间
 */
@property (nonatomic,copy) NSString * lastLoginTime;


/**
 最后查询信息时间
 */
@property (nonatomic,copy) NSString * lastFindTime;


/**
 所属机构
 */
@property (nonatomic,copy) NSString * organize;


/**
 积分
 */
@property (nonatomic,copy) NSString * money;


/**
 环信账户 id
 */
@property (nonatomic,copy) NSString * hxId;


/**
 个人价值
 */
@property (nonatomic,copy) NSString * worth;


/**
 昵称
 */
@property (nonatomic,copy) NSString * nickname;



/**
 图片地址
 */
@property (nonatomic,copy) NSString * photoUrl;



/**
 app令牌
 */
@property (nonatomic,copy) NSString * token;


/**
 密码认证
 */
@property (nonatomic,copy) NSString * authentication;


/**
 实名认证
 */
@property (nonatomic,copy) NSString * identity;


@end
