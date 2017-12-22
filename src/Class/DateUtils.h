//
//  DateUtils.h
//  CorderAlmanac
//
//  Created by caobo56 on 2017/11/28.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject


/**
 获取当前日期星期几的NSInteger值

 @param inputDate 输入日期
 @return return value 返回星期几数值
 */
+(NSInteger)numberOfWeekIn:(NSDate *)inputDate;

/**
 获取当前日期年数的NSInteger值

 @param inputDate 输入日期
 @return return value 返回年数数值
 */
+(NSInteger)numberOfYearIn:(NSDate *)inputDate;

/**
 获取当前日期月数的NSInteger值
 
 @param inputDate 输入日期
 @return return value 返回月数数值
 */
+(NSInteger)numberOfMonthIn:(NSDate *)inputDate;

/**
 获取当前日期天数的NSInteger值
 
 @param inputDate 输入日期
 @return return value 返回天数数值
 */
+(NSInteger)numberOfDayIn:(NSDate *)inputDate;

/**
 获取当前日期小时数的NSInteger值
 
 @param inputDate 输入日期
 @return return value 返回小时数数值
 */
+(NSInteger)numberOfHourIn:(NSDate *)inputDate;

/**
 获取当前日期农历年数的NSInteger值
 
 @param inputDate 输入日期
 @return return value 返回农历年数数值
 */
+(NSInteger)numberOfChinaYearIn:(NSDate *)inputDate;

/**
 获取当前日期农历月数的NSInteger值
 
 @param inputDate 输入日期
 @return return value 返回农历月数数值
 */
+(NSInteger)numberOfChinaMonthIn:(NSDate *)inputDate;

/**
 获取当前日期农历天数的NSInteger值
 
 @param inputDate 输入日期
 @return return value 返回农历天数数值
 */
+(NSInteger)numberOfChinaDayIn:(NSDate *)inputDate;

/**
 获取当前日期后一天的时间

 @param inputDate 输入日期
 @return return value 返回当后日期前一天的时间
 */
+(NSDate *)theAfterDay:(NSDate *)inputDate;

/**
 获取当前日期前一天的时间
 
 @param inputDate 输入日期
 @return return value 返回当前日期前一天的时间
 */
+(NSDate *)theBeforeDay:(NSDate *)inputDate;

/**
 获取当前日期后一年的时间
 
 @param inputDate 输入日期
 @return return value 返回当前日期后一年的时间
 */
+(NSDate *)theAfterMonth:(NSDate *)inputDate;

/**
 获取当前日期前一年的时间
 
 @param inputDate 输入日期
 @return return value 返回当前日期前一年的时间
 */
+(NSDate *)theBeforeMonth:(NSDate *)inputDate;

/**
 ios比较日期大小，只比较到天

 @param oneDay oneDay 一个日期
 @param anotherDay anotherDay 另一个日期
 @return return value NSComparisonResult
 */
+(NSComparisonResult)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 yyyy-MM-dd 的 str 转换为日期
 
 @param str yyyy-MM-dd格式的
 @return return date
 */
+(NSDate *)dateFromString:(NSString *)str;


/**
 用Formatter获取日期的str
 
 @param date NSDate 日期
 @param str Formatter 'YYYY-MM-DD hh:mm:ss'
 @return 日期的str
 */
+(NSString *)getStrWith:(NSDate *)date FromFormatter:(NSString *)str;

/**
 日期去掉时分秒
 
 @param inputDate 日期
 @return return date
 */
+(NSDate *)dateToDay:(NSDate *)inputDate;

@end
