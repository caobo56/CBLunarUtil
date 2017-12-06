//
//  DateUtils.h
//  CorderAlmanac
//
//  Created by caobo56 on 2017/11/28.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

+(NSInteger)numberOfWeekIn:(NSDate *)inputDate;

+(NSInteger)numberOfYearIn:(NSDate *)inputDate;

+(NSInteger)numberOfMonthIn:(NSDate *)inputDate;

+(NSInteger)numberOfDayIn:(NSDate *)inputDate;

+(NSInteger)numberOfHourIn:(NSDate *)inputDate;

+(NSInteger)numberOfChinaYearIn:(NSDate *)inputDate;

+(NSInteger)numberOfChinaMonthIn:(NSDate *)inputDate;

+(NSInteger)numberOfChinaDayIn:(NSDate *)inputDate;

/****
 ios比较日期大小默认会比较到天
 ****/
+(NSComparisonResult)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

/**
 yyyy-MM-dd 的 str 转换为日期
 
 @param str yyyy-MM-dd格式的
 @return return date
 */
+(NSDate *)dateFromString:(NSString *)str;


/**
 日期去掉时分秒
 
 @param inputDate 日期
 @return return date
 */
+(NSDate *)dateToDay:(NSDate *)inputDate;
@end
