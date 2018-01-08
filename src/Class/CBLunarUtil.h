//
//  CBLunarUtil.h
//  CorderAlmanac
//
//  Created by caobo56 on 2017/11/20.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum GanZhiState {
    GanZhiStateDefault = 0,
    StateNongLi,
    StateGanZhiLi
} GanZhiState;
//国内分农历和干支历两中，干支历命理专用

@interface CBLunarUtil : NSObject

/**
 获取日期的星期几

 @param inputDate 输入日期
 @return return value 星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;


/**
 获取日期年份的干支历第一天的公历日--即算出该日期年的立春日

 @param inputDate 输入日期
 @return return value 该日期年的立春日
 */
+ (NSDate*)liChunDateFromDate:(NSDate *)inputDate;


/**
 获取今天是否为节气，不是节气返回@"" 是节气返回节气名称

 @param inputDate 输入日期
 @return 不是节气返回@"" 是节气返回节气名称
 */
+(NSString *)jieqiFromDate:(NSDate *)inputDate;

/**
 获取农历年的日期，可以输入样式
 
 @param date 输入日期
 @param format 输入格式@“yyyy-mm-dd”
 yyyy表示年 mm表示月 dd表示日 格式顺序随意
 @return return value 农历年日历
 */
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date format:(NSString *)format;


/**
 获取年的十二生肖，

 @param inputDate 输入日期
 @param type 定位方式（农历/干支历）
 @return 十二生肖的字符串
 */
+(NSString *)zodiacStringFromDate:(NSDate *)inputDate type:(GanZhiState)type;


/**
 获取农历年的天干地支

 @param inputDate 输入日期
 @return return value 农历年的天干地支
 */
+ (NSString *)yearGanzhiStringFromDate:(NSDate*)inputDate type:(GanZhiState)type;

/**
 获取农历月的天干地支

 @param inputDate 输入日期
 @return return value 农历月的天干地支
 */
+ (NSString *)mouthGanzhiStringFromDate:(NSDate*)inputDate;

/**
 获取农历日的天干地支
 
 @param inputDate 输入日期
 @return return value 农历日的天干地支
 */
+ (NSString *)dayGanzhiStringFromDate:(NSDate*)inputDate;

/**
 获取由农历日获取的十二建/十二值

 @param inputDate 输入日期
 @return return value 农历日的天干地支
 */
+ (NSString *)jianxingStringFromDate:(NSDate*)inputDate;


/**
 根据十二建除获取当日宜忌

 @param inputDate 输入日期
 @return 当日宜忌
 */
+(NSDictionary *)YiJi:(NSDate *)inputDate;

/**
 根据日期获取星座
 
 @param inputDate inputDate description
 @return return value description
 */
+(NSString *)getConstellationByDate:(NSDate *)inputDate;

@end
