//
//  UserManger.m
//  Xtecher
//
//  Created by 王剑亮 on 2017/7/12.
//  Copyright © 2017年 王剑亮. All rights reserved.
//

#import "XTUserManger.h"
//#import <WXApi.h>
//#import <WXApiObject.h>
//#import "XTMineViewController.h"
@interface XTUserManger ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic)  UIImage  * inserImage;                   ///插入的image
@property (strong, nonatomic)  UIImagePickerController *insertPicker; ///插入的vc
@end

@implementation XTUserManger

 static XTUserManger *userManger;
+ (instancetype)shareXTUserManger
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userManger = [[XTUserManger alloc]init];
        
        NSData *data =  [UserDefaults objectForKey:@"XTUserModel"];
        XTUserModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [userManger setUserModel:model];
        
        //当前版本号  版本检测 版本更新之后 清除领域 和 地址的 数据
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        float appVersion = [[infoDictionary objectForKey:@"CFBundleShortVersionString"] floatValue];
        float appVersionLocation =    [UserDefaults floatForKey:@"CFBundleShortVersionString"];
        if (appVersion !=  appVersionLocation) {
            //从新设置版本
            [UserDefaults setFloat:appVersion forKey:@"CFBundleShortVersionString"];
            //清除领域的模型
            [UserDefaults setObject:nil forKey:@"CreateFieldModelArray"];
        }
        
        

        
    });
    
    return userManger;
}

-(void)setUserModel:(XTUserModel *)userModel{
    
    _userModel = userModel;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userModel];
    
    //更新一下 用户模型
    [UserDefaults setObject:data forKey:@"XTUserModel"];
//    //保存一下 前一个用户登录的手机号
//    [UserDefaults setObject:userModel.phone forKey:@"XTUserModelPreviousPhoneNumber"];
//    [UserDefaults synchronize];

}

/**
 清除用户模型的数据 但是保留用户模型的手机号码
 */
+ (void)clearUserModel{

    //清除一下用户模型
    
    [UserDefaults removeObjectForKey:@"XTUserModel"];
    [UserDefaults synchronize];
    /*
    XTMineViewController *VC   =  [[XTMineViewController alloc]initWithNibName:@"XTMineViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    XTUserMangerShareXTUserManger.userModel.token = nil;
    
    SetCurrentWindowRootViewController(nav);
     */
}


//////////////////////////////////////////////////////选择相册或者相机的方法////////////////////////////////////////////////////////////////////

//开始选择相册的方法
- (void)startSelectSysPic{
    
    _inserImage = nil;
    _insertPicker = nil;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"选择打开方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *ac1  = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        PLog(@"取消了！！！！！");
    }];
    UIAlertAction *ac2  = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectPhotoFromType:1];
    }];
    UIAlertAction *ac3  = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self selectPhotoFromType:2];
    }];
    
    [alertVC addAction:ac1 ];
    [alertVC addAction:ac2 ];
    [alertVC addAction:ac3 ];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

/*******************设置照片还是相机**************************/
-(void)selectPhotoFromType:(int)index {
    
    if (index == 2) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            if (self.insertPicker == nil) {
                self.insertPicker = [[UIImagePickerController alloc] init];
                
                [self.insertPicker setDelegate:self];
                self.insertPicker.allowsEditing = YES;
            }
            self.insertPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: self.insertPicker  animated:NO completion:nil];
            
        }else {
            [SVProgressHUD showWithStatus:@"相机不可用"];
            [SVProgressHUD dismissWithDelay:0.8];
            
        }
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            if (self.insertPicker == nil) {
                self.insertPicker = [[UIImagePickerController alloc] init] ;
                self.insertPicker.allowsEditing = YES;
                
                self.insertPicker.delegate = self;
            }
            self.insertPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController: self.insertPicker  animated:NO completion:nil];
            
        }
        else {
            [SVProgressHUD showWithStatus:@"相册不可用"];
            [SVProgressHUD dismissWithDelay:0.8];
        }
    }
}


#pragma mark - UIImagePickerControllerDelegate


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ///图片处理
    if (picker == self.insertPicker){
        
        UIImage *newImage = [info valueForKey:UIImagePickerControllerEditedImage];
        if(!newImage)
            newImage = [info valueForKey:UIImagePickerControllerOriginalImage];
        
        WDImageScaleTool *scaleTools =     [[WDImageScaleTool alloc]init];
        
        PLog(@"选来的图片的大小 === %luKB",(unsigned long)UIImageJPEGRepresentation(newImage, 1).length/1000);
        self.inserImage = [scaleTools WDImageFormatAndScaleRecycleCompressionWithImage:newImage maxSize:CGSizeMake(200, 200) maxDataByte:50];
        PLog(@"选择的图片的大小 === %luKB",(unsigned long)UIImageJPEGRepresentation(self.inserImage, 1).length/1000);
        
        [self.insertPicker dismissViewControllerAnimated:YES completion:nil];
        
        if (_imageBlock) {
            self.imageBlock(self.inserImage);
        }
    }
}
//////////////////////////////////////////////////////相册或者相机的方法结束////////////////////////////////////////////////////////////////////

//////////////微信分享的方法//////////////////////////////////////////////////////

- (void) sendLinkContentUrl:(NSString *)url
{
    /*
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"邀请微信好友填写信息";
    message.description = @"采访小助手邀请您帮助好友填写信息";
    [message setThumbImage:[UIImage imageNamed:@"weichat.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
     */
}


@end
