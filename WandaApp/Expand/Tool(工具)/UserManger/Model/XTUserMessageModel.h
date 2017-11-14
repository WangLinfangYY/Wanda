//
//  XtUserMessageModel.h
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/24.
//  Copyright © 2017年 王剑亮. All rights reserved.
//


// 我的界面 -- 个人信息模型 -- 修改个人信息模型
#import "XTBaseModel.h"
/**
 个人信息的模型
 */
@interface XTUserMessageModel : XTBaseModel

/**
 用户id
 */
@property (nonatomic,copy) NSString * id;

/**
 头像地址
 */
@property (nonatomic,copy) NSString * photoPath;

/**

 */
@property (nonatomic,copy) NSString * flollowNum;

/**
 
 */
@property (nonatomic,copy) NSString * notifyNum;

/**
 
 */
@property (nonatomic,copy) NSString * collectionNum;

/**
 
 */
@property (nonatomic,copy) NSString * photo;

/**
 
 */
@property (nonatomic,copy) NSString * nickName;
@property (nonatomic,copy) NSString * nickname;
/**
 判断是不是记者
 */
@property (nonatomic,copy) NSString * role;
/**
简介
 */
@property (nonatomic,copy) NSString * summary;

@property (nonatomic,assign) BOOL isColumnData;
@end
