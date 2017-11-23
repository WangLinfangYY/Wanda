//
//  WDHomeController.m
//  WandaApp
//
//  Created by 王林芳 on 2017/11/17.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import "WDHomeController.h"

@interface WDHomeController ()

@end

@implementation WDHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}
- (void)createUI
{
    self.title = @"万达网络办公系统";
}
- (IBAction)btnClick:(UIButton *)sender {
    PLog(@"-------------%ld",sender.tag);
    switch (sender.tag) {
        case 0:
            //图纸管理
            break;
        case 1:
            //设计变更
            break;
        case 2:
            //签证管理
            break;
        case 3:
            //内控计划及销项
            break;
        case 4:
            //约车
            break;
        case 5:
            //工作日志
            break;
            
        default:
            break;
    }
}

@end
