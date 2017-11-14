//
//  HTTPConfig.h
//  WandaApp
//
//  Created by 王林芳 on 2017/11/14.
//  Copyright © 2017年 王林芳. All rights reserved.
//

#ifndef HTTPConfig_h
#define HTTPConfig_h

#define  XTAppBaseURL @"http://123.57.174.120:9080/xtecherWebsite-api/"


//#define  XTAppBaseURL @"http://47.94.42.220:8080/xtecherWebsite-api/"

//志飞
//#define  XTAppBaseURL    @"http://123.57.174.120:9080/"


//王越
//#define  XTAppBaseURL    @"http://172.17.233.154:8083/"


//暂无
//#define  XTAppBaseURL    @"http://172.17.224.106:8080/



//海哥
//#define  XTAppBaseURL    @"http://172.17.224.119:8083/"



//宏定义封装一下

#define XTToken                  [XTAPPService shareAppService].token
#define XTAppVersion          @"4.3"
#define XTIOS                      @"iOS"
#define XTCHANNELNUM    @"AppStore"

#define XTTimeOutInterval   10

typedef enum {
    
    XTRequestStatusOK =   0,
    XTRequestStatusError = 1
    
    
}XTRequestStatus;
#endif /* HTTPConfig_h */
