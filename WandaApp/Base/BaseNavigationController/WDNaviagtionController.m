//
//  WDNaviagtionController.m
//  WandaApp
//
//  Created by 王林芳 on 2017/11/17.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import "WDNaviagtionController.h"

@interface WDNaviagtionController ()

@end

@implementation WDNaviagtionController

+ (void)initialize
{
    [[UINavigationBar appearance]setBarTintColor:[UIColor blueColor]];
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



@end
