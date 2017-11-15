//
//  WLFSignatureViewController.m
//  WandaApp
//
//  Created by 王林芳 on 2017/11/15.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import "WLFSignatureViewController.h"
#import "PJRSignatureView.h"
@interface WLFSignatureViewController ()

@end

@implementation WLFSignatureViewController
{
    PJRSignatureView *signatureView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self .view setBackgroundColor:[UIColor greenColor]];
    [self createUI];
}
- (void)createUI
{
    //添加签名视图
    signatureView = [[PJRSignatureView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 300)];
    [self.view addSubview:signatureView];
    [signatureView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@80);
        make.left.mas_equalTo(@20);
        make.right.mas_equalTo(@(-20));
        make.height.mas_equalTo(@200);
    }];
    
    //添加按钮
    UIButton *btn_clear = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_clear setTitle:@"清除" forState: UIControlStateNormal];
    [btn_clear setBackgroundColor:[UIColor lightGrayColor]];
    [btn_clear addTarget:self action:@selector(btn_clearClick) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:btn_clear];
    [btn_clear mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(signatureView.mas_bottom).offset(30);
        make.left.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(36);
    }];
    
    UIButton *btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [btn_cancel setBackgroundColor:[UIColor lightGrayColor]];
    [btn_cancel addTarget:self action:@selector(btn_cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_cancel];
    [btn_cancel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(@0);
        make.centerY.mas_equalTo(btn_clear.mas_centerY);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@36);
    }];
    
    UIButton *btn_confirm = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_confirm setTitle:@"确定" forState:UIControlStateNormal];
    [btn_confirm setBackgroundColor:[UIColor lightGrayColor]];
    [btn_confirm addTarget:self action:@selector(btn_confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn_confirm];
    [btn_confirm mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(btn_clear.mas_centerY);
        make.right.mas_equalTo(@(-30));
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@36);
    }];
    
}
- (void)btn_clearClick
{
    [signatureView clearSignature];
}
- (void)btn_cancelClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)btn_confirmClick
{
    UIImage *image =[signatureView getSignatureImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.block_signCallback(image);
}

- (void)getSignWithOK:(SignCallBackBlock)callBack cancel:(SignCancelBlock)cancel
{
    self.block_signCallback = callBack;
    self.block_signCancel = cancel;
}
@end




























