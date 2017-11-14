//
//  QHCommonMacro.h
//  Foundation
//
//  Created by Keldon on 16/6/7.
//
//

#ifndef QHCommonMacro_h
#define QHCommonMacro_h

#pragma mark - UI相关全局宏定义
#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height          //包含状态bar的高度(e.g. 480)

#define kApplicationSize      [[UIScreen mainScreen] applicationFrame].size       //(e.g. 320,460)
#define kApplicationWidth     [[UIScreen mainScreen] applicationFrame].size.width //(e.g. 320)
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)
#define kSystemVesion         [[[UIDevice currentDevice] systemVersion] floatValue]

#define iphone4DeviceHeight           480.0f
#define iphone5DeviceHeight           568.0f

#define navBarOrigin (kIOSVersions>=7.0?64:44)
#define kNavigationBarHeight  44
#define kStatusBarHeight      20


#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBValue(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define UIColorFromRGBAValue(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#pragma mark- UIDevice size
//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define IS_SCREEN_4_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_35_INCH	([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),  [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_47_INCH   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IS_SCREEN_55_INCH   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define DiffHeight (IS_SCREEN_4_INCH ? 88 : 0) //(1136-960)/2

#define isPad ([[[UIDevice currentDevice] model] rangeOfString:@"iPad"].location != NSNotFound)
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)

// 是否IPAD
#define kIPAD   @"iPad"
#define IS_IPAD ([[[UIDevice currentDevice] model] isEqualToString:kIPAD] ? YES : NO)

#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本

#define kContentHeight        (kScreenHeight - kNavigationBarHeight - kStatusBarHeight)

#define kUnderStatusBarStartY (kSystemVesion>=7.0 ? 20 : 0) //7.0以上stautsbar不占位置，内容视图的起始位置要往下20

#define kContentStartY        (kSystemVesion>=7.0 ? 64 : 0) //7.0以上stautsbar，navbar不占位置，内容视图的起始位置要往下64

// 日期格式
#define kDateFormate_yyyy            @"yyyy"
#define kDateFormate_MM              @"MM"
#define kDateFormate_yyyy_MM         @"yyyy-MM"
#define kDateFormate_yyyy_MM_dd      @"yyyy-MM-dd"
#define kDateFormate_yyyyMMdd        @"yyyyMMdd"
#define kDateFormate_yyyyMMddHH      @"yyyyMMddHH"
#define kDateFormate_yyyyMMddHHmmss  @"yyyyMMddHHmmss"

// iOS系统宏
#define IOS10_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 10 )
#define IOS9_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 9 )
#define IOS8_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 8 )
#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 7 )
#define IOS6_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 6 )
#define IOS5_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 5 )
#define IOS4_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 4 )
#define IOS3_OR_LATER		( [[[UIDevice currentDevice] systemVersion] intValue] >= 3 )

#define IOS7_OR_EARLIER		( !IOS8_OR_LATER )
#define IOS6_OR_EARLIER		( !IOS7_OR_LATER )
#define IOS5_OR_EARLIER		( !IOS6_OR_LATER )
#define IOS4_OR_EARLIER		( !IOS5_OR_LATER )
#define IOS3_OR_EARLIER		( !IOS4_OR_LATER )


// iOS编译环境
#if defined(DEBUG)||defined(_DEBUG)

#define DEBUG_VER   1
#define RELEASE_VER 0

#else

#define DEBUG_VER   0
#define RELEASE_VER 1

#endif

// 函数运行时间 间隔函数定义
#define TICK_TIME_BEGIN    NSDate* date = [NSDate date];
#define TICK_TIME_END      NSTimeInterval interval = [[NSDate date]timeIntervalSinceDate:date]; \
printf("time interval is:%.4f", (double)interval);


#endif /* QHCommonConfig_h */
