//
//  WLFSignatureViewController.h
//  WandaApp
//
//  Created by 王林芳 on 2017/11/15.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SignCallBackBlock) (UIImage *image);
typedef void (^SignCancelBlock) ();
@interface WLFSignatureViewController : UIViewController

@property (nonatomic,copy) SignCallBackBlock block_signCallback;
@property (nonatomic,copy) SignCancelBlock block_signCancel;

- (void) getSignWithOK:(SignCallBackBlock)callBack cancel:(SignCancelBlock)cancel;
@end
