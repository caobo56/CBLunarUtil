//
//  CBLunarUtil.m
//  CorderAlmanac
//
//  Created by caobo56 on 2017/11/20.
//  Copyright © 2017年 caobo56. All rights reserved.
//

#import "CBLunarUtil.h"
#import "DateUtils.h"
#import "LJsonFileUtils.h"

@implementation CBLunarUtil

+(NSArray *)jiaziArr{
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子",@"乙丑",@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",
                             @"甲戌",@"乙亥",@"丙子",@"丁丑",@"戊寅",@"己卯",@"庚辰",@"辛巳",@"壬午",@"癸未",
                             @"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑",@"庚寅",@"辛卯",@"壬辰",@"癸巳",
                             @"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑",@"壬寅",@"癸丑",
                             @"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑",
                             @"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥",nil];
    return chineseYears;
}


/**
 获取当天为星期几

 @param inputDate 输入日期
 @return 返回星期几
 */
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    return [weekdays objectAtIndex:[DateUtils numberOfWeekIn:inputDate]];
}

/**
 获取日期年份的干支历第一天的公历日--即算出该日期年的立春日
 //立春一直是二月的3日或者4日
 @param inputDate 输入日期
 @return return value 该日期年的立春日
 */
+ (NSDate*)liChunDateFromDate:(NSDate *)inputDate{
    NSInteger year = [DateUtils numberOfYearIn:inputDate];
    NSMutableArray * jieArr = [NSMutableArray arrayWithArray:(NSArray *)[LJsonFileUtils dataWithJsonFile:[NSString stringWithFormat:(@"%ld"),(long)year]]];
    NSDictionary * dict = jieArr[0];
    NSString *str = [dict[@"time"] substringToIndex:10];
    return [DateUtils dateFromString:str];
}

+(NSString *)jieqiFromDate:(NSDate *)inputDate{
    NSInteger year = [DateUtils numberOfYearIn:inputDate];
    NSMutableArray * jieArr = [NSMutableArray arrayWithArray:(NSArray *)[LJsonFileUtils dataWithJsonFile:[NSString stringWithFormat:(@"%ld"),(long)year]]];
    NSString * jieqi = @"";
    for (NSDictionary * item in jieArr) {
        NSString *day_str = [item[@"time"] substringToIndex:10];
        NSDate * date = [DateUtils dateFromString:day_str];
        NSComparisonResult result = [DateUtils compareOneDay:inputDate withAnotherDay:date];
        if (result == NSOrderedSame) {
            jieqi = item[@"name"];
            break;
        }
    }
    return jieqi;
}

/**
 获取农历年月日

 @param date 输入日期
 @return 返回干支年 农历月份 农历初几
 */
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date format:(NSString *)format{
    NSArray *chineseMonths = [NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    NSArray *chineseDays = [NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    NSString *y_str = [CBLunarUtil yearGanzhiStringFromDate:date type:StateNongLi];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    format = [format stringByReplacingOccurrencesOfString:@"yyyy" withString:y_str];
    format = [format stringByReplacingOccurrencesOfString:@"mm" withString:m_str];
    format = [format stringByReplacingOccurrencesOfString:@"dd" withString:d_str];
    return format;
}

+(NSString *)zodiacStringFromDate:(NSDate *)inputDate type:(GanZhiState)type{
    NSArray *lunarZodiac = [NSArray arrayWithObjects:@"鼠",@"牛",@"虎",@"兔",@"龙",@"蛇",@"马",@"羊",@"猴",@"鸡",@"狗",@"猪",nil];
    NSArray * dizhi_arr = [NSArray arrayWithObjects:@"子",@"丑",@"寅",@"卯",@"辰",@"巳",@"午",@"未",@"申",@"酉",@"戌",@"亥",nil];
    NSString * year_ganzhi_str = [CBLunarUtil yearGanzhiStringFromDate:inputDate type:type];
    NSString * zodiac = @"";
    for (int i = 0; i < lunarZodiac.count;i++ ) {
        if ([year_ganzhi_str containsString:dizhi_arr[i]]) {
            zodiac = lunarZodiac[i];
            break;
        }
    }
    return zodiac;
}

/**
 获取年的干支，
 因为干支历一年的起始日期是从立春开始的，
 不是农历年严格意义上的第一天，
 所以具体到某一天的年，需要做区别对待
 @param inputDate 日期
 @return return 年的干支
 */
+ (NSString *)yearGanzhiStringFromDate:(NSDate*)inputDate type:(GanZhiState)type{
    NSArray *chineseYears = [CBLunarUtil jiaziArr];
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:inputDate];
    NSString *y_str;
    NSInteger y_index = localeComp.year-1;
    NSInteger m_index = localeComp.month;
    if(type == StateGanZhiLi){
        NSComparisonResult result = [inputDate compare:[CBLunarUtil liChunDateFromDate:inputDate]];
        if ((result == NSOrderedAscending) && (m_index == 1)){
            y_index = y_index-1;
        }else{
            y_index = y_index;
        }
        //如果过了元旦之后的公历日期小于立春日，
        //则此时上一年的干支历还未走完，
        //需要年天干地支回退到上一年的天干地支
        if (y_index == 0) {
            y_index = 60;
        }else if ((result != NSOrderedAscending) && (m_index == 12)){
            y_index++;
            m_index = 1;
        }
    }
    y_str = [chineseYears objectAtIndex:(long)y_index];
    return y_str;
}

/**
 月干支的另一种算法
 知道年干后，月干的计算方法很简单：
 月干＝年干代数x2+月数。
 对应的代号就是该月月干。
 超过10时，去掉10的倍数用其余数。
 月支是以正月起寅，依次类推……
 */
+(NSString *)mouthGanzhiStringFromDate:(NSDate *)inputDate{
    NSDictionary * mouthDizhi = @{
                                  @"甲&己":@[@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",@"甲戌",@"乙亥",@"丙子",@"丁丑"],
                                  @"乙&庚":@[@"戊寅",@"己卯",@"庚辰",@"辛巳",@"壬午",@"癸未",@"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑"],
                                  @"丙&辛":@[@"庚寅",@"辛卯",@"壬辰",@"癸巳",@"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑"],
                                  @"丁&壬":@[@"壬寅",@"癸卯",@"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑"],
                                  @"戊&癸":@[@"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥",@"甲子",@"乙丑"]
                                  };
    NSString * year_ganzhi = [CBLunarUtil yearGanzhiStringFromDate:inputDate type:StateGanZhiLi];
    NSInteger mouth_zhi_index = [CBLunarUtil mouthZhiIndexFromDate:inputDate];
    NSArray * dizhi_arr = [mouthDizhi allKeys];
    NSString * mouth_ganzhi;
    for (NSString * str in dizhi_arr) {
        if ([str containsString:[year_ganzhi substringToIndex:1]]) {
            NSArray * arr = [mouthDizhi objectForKey:str];
            mouth_ganzhi = arr[mouth_zhi_index];
        }
    }
    return mouth_ganzhi;
}


/**
 月的地支计算

 @param inputdate 输入日期
 @return return 月支的index
 */
+(NSInteger)mouthZhiIndexFromDate:(NSDate *)inputdate{
    NSInteger year = [DateUtils numberOfYearIn:inputdate];
    NSMutableArray * jieArr = [NSMutableArray arrayWithArray:(NSArray *)[LJsonFileUtils dataWithJsonFile:[NSString stringWithFormat:(@"%ld"),(long)year]]];
    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES]];
    [jieArr sortUsingDescriptors:sortDescriptors];
    int index = 0;
    for (int i  = 0;i < jieArr.count ;i++ ) {
        NSDictionary * dict = jieArr[i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:[dict[@"time"] substringToIndex:10]];
        NSComparisonResult res = [DateUtils compareOneDay:inputdate withAnotherDay:date];
        if (res == NSOrderedAscending) {
            break;
        }else{
            index++;
        }
    }
    NSInteger zhi_id = (index+1)/2;
    if (zhi_id == 0) {
        zhi_id = 10;
    }else if (zhi_id == 1){
        zhi_id = 11;
    }else{
        zhi_id = zhi_id-2;
    }
    return zhi_id;
}


/**
 计算日干支

 @param inputDate 输入日期
 @return 返回当日干支
 */
+ (NSString *)dayGanzhiStringFromDate:(NSDate*)inputDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear |NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    NSInteger y = theComponents.year%100+100;
    NSInteger m = theComponents.month;
    NSInteger d = theComponents.day;
    
    NSInteger gan_index = y*5 + y/4 + 9 + d;
    if (m%2 == 0) {
        gan_index = gan_index + 30;
    }
    NSInteger offset = 0;
    if(m == 1 || m == 2){
        offset = m;
        if(y%4 == 0){
            offset--;
        }
    }else if (m == 4||m == 5) {
        offset = 1;
    }else if(m == 6||m == 7){
        offset = 2;
    }else if (m == 8){
        offset = 3;
    }else if(m == 9||m == 10){
        offset = 4;
    }else if (m == 11||m == 12){
        offset = 5;
    }
    gan_index = gan_index + offset;
    gan_index = gan_index%60;
    if (gan_index == 0) {
        gan_index = 59;
    }else{
        gan_index--;
    }
    NSArray *ganzhi_Arr = [CBLunarUtil jiaziArr];
    return ganzhi_Arr[gan_index];
}


/**
 计算十二建星

 @param inputDate 输入日期
 @return 返回当天的建星
 */
+(NSString *)jianxingStringFromDate:(NSDate*)inputDate{
    NSDictionary * dayjianxing = @{
                                   @"子":@[@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭"],
                                   @"丑":@[@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建"],
                                   @"寅":@[@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除"],
                                   @"卯":@[@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满"],
                                   @"辰":@[@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定",@"平"],
                                   @"巳":@[@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执",@"定"],
                                   @"午":@[@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破",@"执"],
                                   @"未":@[@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危",@"破"],
                                   @"申":@[@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成",@"危"],
                                   @"酉":@[@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收",@"成"],
                                   @"戌":@[@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开",@"收"],
                                   @"亥":@[@"收",@"成",@"危",@"破",@"执",@"定",@"平",@"满",@"除",@"建",@"闭",@"开"]
                                   };
    
    NSInteger mouth_zhi_index = [CBLunarUtil mouthZhiIndexFromDate:inputDate];
    NSString * day_ganzhi = [CBLunarUtil dayGanzhiStringFromDate:inputDate];
    NSArray * day_zhi_Arr = [dayjianxing allKeys];
    NSString * jian;
    for (NSString * zhi in day_zhi_Arr) {
        if ([day_ganzhi containsString:zhi]) {
            NSArray * jian_Mouth = [dayjianxing objectForKey:zhi];
            jian = jian_Mouth[mouth_zhi_index];
            break;
        }
    }
    return jian;
}

+(NSDictionary *)YiJi:(NSDate *)inputDate{
    NSDictionary * YiJi_dict = @{@"建日":@{@"宜":@"出行,上任,会友,上书,见工",@"忌":@"动土,开仓,嫁娶,纳采"},
                                 @"除日":@{@"宜":@"除服,疗病,出行,拆卸,入宅",@"忌":@"求官,上任,开张,搬家,探病"},
                                 @"满日":@{@"宜":@"祈福,祭祀,结亲,开市,交易",@"忌":@"服药,求医,栽种,动土,迁移"},
                                 @"平日":@{@"宜":@"祭祀,修墳,涂泥,餘事勿取",@"忌":@"移徙,入宅,嫁娶,开市,安葬"},
                                 @"定日":@{@"宜":@"交易,立券,会友,签約,納畜",@"忌":@"种植,置业,卖田,掘井,造船"},
                                 @"执日":@{@"宜":@"祈福,祭祀,求子,结婚,立约",@"忌":@"开市,交易,搬家,远行"},
                                 @"破日":@{@"宜":@"",@"忌":@"是日值月破,大事不宜"},
                                 @"危日":@{@"宜":@"经营,交易,求官,納畜,動土",@"忌":@"登高,行船,安床,入宅,博彩"},
                                 @"成日":@{@"宜":@"祈福,入学,开市,求医,成服",@"忌":@"词讼,安門,移徙"},
                                 @"收日":@{@"宜":@"祭祀,求财,签约,嫁娶,订盟",@"忌":@"开市,安床,安葬,入宅,破土"},
                                 @"开日":@{@"宜":@"疗病,结婚,交易,入仓,求职",@"忌":@"安葬,动土,针灸"},
                                 @"闭日":@{@"宜":@"祭祀,交易,收财,安葬",@"忌":@"宴会,安床,出行,嫁娶,移徙"}};
    NSArray * jianxing_arr = [YiJi_dict allKeys];
    NSString * jian = [CBLunarUtil jianxingStringFromDate:inputDate];
    NSDictionary * yiji = @{};
    for (NSString * jianxingStr in jianxing_arr) {
        if ([jianxingStr containsString:jian]) {
            yiji = YiJi_dict[jianxingStr];
            break;
        }
    }
    return yiji;
}


@end
















