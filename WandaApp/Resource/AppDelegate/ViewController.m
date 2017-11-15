//
//  ViewController.m
//  WandaApp
//
//  Created by 王林芳 on 2017/11/13.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import "ViewController.h"
#import "PopSignUtil.h"
#import "WLFSignatureViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self createUI];
}
- (void)createUI
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击签名" forState: UIControlStateNormal];
    [btn setBackgroundColor: [UIColor blueColor]];
    [btn addTarget:self action:@selector(addSignClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view);
        make.width.equalTo(@200);
        make.height.equalTo(@130);
    }];
}
- (void)addSignClick:(UIButton *)sender
{
    PLog(@"点击签名");
    /*
    [PopSignUtil getSignWithVC:self withOk:^(UIImage *image) {
        [PopSignUtil closePop];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } withCancel:^{
        [PopSignUtil closePop];
        
    }];
     */
    WLFSignatureViewController *signatureVC = [[WLFSignatureViewController alloc]init];
    [self presentViewController:signatureVC animated:YES completion:nil];
    
    [signatureVC getSignWithOK:^(UIImage *image) {
        [sender setBackgroundImage:image forState:UIControlStateNormal];
    } cancel:^{
        
    }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate
{
    return NO;
}

@end






















