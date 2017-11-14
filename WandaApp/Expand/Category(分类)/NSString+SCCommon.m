//
//  NSString+Common.m
//  TaxiDriver
//
//  Created by Mac on 16/8/19.
//  Copyright © 2016年 ShouYueTechnology. All rights reserved.
//

#import "NSString+SCCommon.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (SCCommon)

//判断手机号码
- (BOOL)isPhoneNumber
{
//    NSString *Regex = @"(13[0-9]|14[57]|15[012356789]|17[0-9]|18[0-9])\\d{8}";
     //原来的好像是不对 下面是替换的正则表达式  王剑亮修改
    NSString *Regex = @"^((13[0-9])|(15[^4,\\D])|17[0-9]|(18[0,0-9]))\\d{8}$";
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [mobileTest evaluateWithObject:self];
}



- (NSArray *)regularkuohao
{
    //设定总的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"\\【.*?\\】"];
    //根据正则表达式设定OC规则
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //获取匹配结果
    NSArray *results = [regular matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    /***理解测试代码****/
    //遍历结果
    NSMutableArray *array = [NSMutableArray array];
    for (NSTextCheckingResult *result in results) {
        
        [array addObject:[self substringWithRange:result.range]];
    }
    //    SCLog(@"%@",array);
    return array;
}

//判断是否是联系方式（座机或手机号）
- (NSArray *)regularPhone
{
    //设定总的正则表达式
    NSString *pattern = [NSString stringWithFormat:@"%@",@"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)"];
    //根据正则表达式设定OC规则
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //获取匹配结果
    NSArray *results = [regular matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    /***理解测试代码****/
    //遍历结果
    NSMutableArray *array = [NSMutableArray array];
    for (NSTextCheckingResult *result in results) {
        
        [array addObject:[self substringWithRange:result.range]];
    }
    //    SCLog(@"%@",array);
    return array;
    /**
     *  参考链接
     http://www.cnblogs.com/flyker/archive/2009/02/12/1389435.html
     */
}

//Email验证
- (BOOL)isEmail
{
    NSString *emailRegex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

//是否都为空格
- (BOOL)isAllSpaceText
{
    BOOL isAllSpace = YES;
    NSString *textOhter = [self trimString];
    if (textOhter && textOhter.length > 0) {
        isAllSpace = NO;
    }
    return isAllSpace;
}
- (NSString *)trimString {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
- (NSString *)NSUTF8StringEncoding
{

   return  [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
#pragma mark 加密
- (NSString *)md5Str
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*) sha1Str
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

//转化为Data
- (NSData *)convertToData {
    NSData* dataResult = [self dataUsingEncoding:NSUTF8StringEncoding];
    return dataResult;
}



/**
 *  计算文字大小
 */
- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    CGSize titleSize;
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0
    titleSize = [self sizeWithFont:font constrainedToSize:size];
#endif
    NSDictionary *attributes = @{NSFontAttributeName:font};
    titleSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return titleSize;
}


/**
 *  时间戳转日期
 *
 *  @return yyyy年MM月dd日
 */
- (NSString *)timestampToTimeStr
{
    NSTimeInterval timestamp = [self doubleValue];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

/**
 航班定制日期字符串 转日期
 2017-03-17 09:05:00
 @return 日期
 */
- (NSDate *)flightCustomDateStrToDate
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [dateFormatter dateFromString:self];
    
    return date;
}

//判断是否为整形
- (BOOL)isInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

-(NSRange)rangeOfAll
{
    return  NSMakeRange(0, self.length);
}


- (id)JSONObject
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    return obj;
}

- (CGSize)rectWithFontSize:(CGFloat)fontSize width:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(0, 0, width, 100);
    textView.text = self;
    textView.font = [UIFont systemFontOfSize:fontSize];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, 1000)];
    [textView sizeToFit];
    size = textView.contentSize;
    return size;
}
#pragma mark - 自适应高度
- (CGRect)stringRectWithfontSize:(CGFloat)fontSize contentSize:(CGSize)size
{
    CGRect stringRect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return stringRect;
}
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font
{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (CGSize)sizeWithLabelHeight:(CGFloat)height font:(UIFont *)font
{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (NSMutableAttributedString *)attributedStringTextFont:(UIFont *)textFont
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];

    [attributedString addAttribute:NSFontAttributeName
                              value:textFont
                              range:NSMakeRange(0, self.length)];
    
    return attributedString;
}
- (NSMutableAttributedString *)attributedStringTextColor:(UIColor *)textColor
{
   return  [self attributedStringTextColor:textColor range:NSMakeRange(0, self.length)];
}
- (NSMutableAttributedString *)attributedStringTextColor:(UIColor *)textColor range:(NSRange)range
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];
    
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:textColor
                             range:range];
    
    return attributedString;
}
- (NSMutableAttributedString *)attributedStringTextColorArray:(NSArray *)textColorArray rangeArray:(NSArray *)rangeArray
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];
    
    for (NSInteger i = 0; i<rangeArray.count; i++) {
        
        NSString *rangeString = rangeArray[i];

        NSArray *array = [rangeString componentsSeparatedByString:@","];
        
        NSRange range = NSMakeRange([array[0] integerValue], [array[1] integerValue]);
        
        UIColor *textColor = nil;
        
        @try {
            
            textColor = textColorArray.lastObject;
            
        } @catch (NSException *exception) {
            
            textColor = textColorArray.lastObject;
            
        } @finally {
            
            [attributedString addAttribute:NSForegroundColorAttributeName
                                     value:textColor
                                     range:range];
            
        }

    }

    return attributedString;
}
- (NSMutableAttributedString *)attributedStringLink:(NSURL *)link
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self];

   [attributedString addAttribute:NSLinkAttributeName
                            value:link
                            range:NSMakeRange(0, self.length)];

    return attributedString;
}

- (NSMutableAttributedString *)attributedStringHTMLText
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    return attributedString;
}
- (NSString *)HTMLColor:(NSString *)textHexColor
{
    NSString *memo = [@"" stringByAppendingFormat:@"<font color=\"%@\">",textHexColor];
    
    memo = [memo stringByAppendingString:self];
    
    memo = [memo stringByAppendingString:@"</font>"];
    
    return memo;
}

#pragma mark 检查车牌号
- (BOOL)checkCarID
{
    
//    NSString *matchStr = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$|^[a-zA-Z]{2}\\d{7}$";
//    
//    BOOL ret = [name isMatchedByRegex:matchStr];
//    
//    return ret;
    
   return   [NSString checkCarID:self];
}
+(BOOL)checkCarID:(NSString *)carID;
{
    if (carID.length!=7) {
        return NO;
    }
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-hj-zA-HJ-Z]{1}[a-hj-zA-HJ-Z_0-9]{4}[a-hj-zA-HJ-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    return [carTest evaluateWithObject:carID];
    return YES;
}


- (BOOL)isEmptyAndNil{
   
    if ([self isEqualToString:@"0"] || [self isEqualToString:@""]  ) {
        
        return YES;
    }

    return NO;
}


+(NSString*)getUuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    result = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return result;
}


/**
 根据逗号分割字符串 获取第一个 id 的字符串

 @return  第一个id 的字符串
 */
- (NSString *)getFirstStr{

    NSArray *array = [self componentsSeparatedByString:@","];
    return array[0];
}





/**
 * 验证身份证号，只能输入数字、“X”和“x”，共18个字符
 */
- (BOOL)validateIdCard{
    
    NSString *regex = @"^\\d{17}[0-9xX]$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject: self]) {
        return NO;
    }
    return YES;
    
}

/**
 * 验证护照号，只能输入"G加8位数字"或"E加8位数字"，共9个字符
 */
- (BOOL)validatePassportCard{
    NSString *regex = @"^[EG]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject: self]) {
        return NO;
    }
    return YES;
    
}
/**
 * 验证港澳通行证号，只能输入"W加8位数字"或"C加8位数字"，共9个字符
 */
- (BOOL)validateGangAoPassportNumber{
    NSString *regex = @"^[CW]\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject: self]) {
        return NO;
    }
    return YES;
}


- (BOOL)PassWordLimt{
    NSString *emailRegex = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z]{6,12}$";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPredicate evaluateWithObject:self];
}

/**
 时间转换
 @param time 时间的秒数
 @return 时间字符串
 */
+ (NSString *)convertStringWithTime:(float)time {
    if (isnan(time)) time = 0.f;
    int hours = (int)time%(3600*24) / 3600;
    int min = (int)time%3600 / 60;
    int sec = (int)time%60 / 1;
    
    NSString * hoursStr = hours > 9 ? [NSString stringWithFormat:@"%d",hours] : [NSString stringWithFormat:@"0%d",hours];
    NSString * minStr = min > 9 ? [NSString stringWithFormat:@"%d",min] : [NSString stringWithFormat:@"0%d",min];
    NSString * secStr = sec > 9 ? [NSString stringWithFormat:@"%d",sec] : [NSString stringWithFormat:@"0%d",sec];
    NSString * timeStr = [NSString stringWithFormat:@"%@:%@:%@",hoursStr,minStr, secStr];
    return timeStr;
}


@end
