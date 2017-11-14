//
//  ColumnModel.h
//  Xtecher
//
//  Created by 凯瑞 on 2017/10/10.
//  Copyright © 2017年 李晓光. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColumnModel : NSObject



/**
 专栏头像
 */
@property(copy,nonatomic) NSString *photo;
/**
 真实姓名
 */
@property(copy,nonatomic) NSString *name;

/**
 专栏名称
 */
@property(copy,nonatomic) NSString *title;

/**
 专栏简介
 */
@property(copy,nonatomic) NSString *summary;

/**
证明材料
 */
@property(copy,nonatomic) NSString *url;

/**
证明材料截图
 */
@property(copy,nonatomic) NSString *screenshot;

/**
身份证号
 */
@property(copy,nonatomic) NSString *idCard;

/**
身份证照片(附件ID)
 */
@property(copy,nonatomic) NSString *idPhoto;

/**
电话
 */
@property(copy,nonatomic) NSString *number;

/**
 邮箱
 */
@property(copy,nonatomic) NSString *email;

/**
 二维码
 */
@property(copy,nonatomic) NSString *qrCode;

/**
 状态判断
 */

@property(copy,nonatomic) NSString *status;// 处理结果(0新提交 1通过 2拒绝）


@property(copy,nonatomic) NSString *id;




///**
// 专栏头像
// */
//@property(copy,nonatomic) NSString *photoFile;
//
///**
//身份证照片
// */
//@property(copy,nonatomic) NSString *idPhotoFile;
//
///**
//二维码照片
// */
//@property(copy,nonatomic) NSString *qrCodeFile;
//
///**
//证明材料照片
// */
//@property(copy,nonatomic) NSString *screenshotFile;


@end


/*
 3.2.2新增专栏资料
 接口：
 /userColumn/saveColumn
 参数：
 photoFile（专栏头像）    idPhotoFile （身份证照）   qrCodeFile   （二维码照片）  screenshotFile （证明材料）
 */
