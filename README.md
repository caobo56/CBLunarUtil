# CBLunarUtil
# 农历库，干支历库，能很容易的获取2000年~2100年的农历推算和干支历推算

### 引入工程
可以通过pod安装管理，也可以直接将代码拖进工程
```
pod 'CBLunarUtil'
```

###整个项目分三个部分：

1）最主要的是CBLunarUtil类，这个类里面全是类方法，支持对NSDate转换成农历和干支历的类方法。

2）然后有一个DateUtils。这个类是对NSDate 的扩展，方便调用获取传入NSDate对象是月的第几天，星期几等。

3）LJsonFileUtils是一个自定义的读取json文件的工具，仅有一个dataWithJsonFile的类函数。

相关函数调用方式以及函数注释，都写在代码里了，可以直接查看使用。

其中，CBLunarUtil 主要是依靠 NSDateComponents 作为核心代码，来核算相关数据。

不得不说，iOS系统提供的这种方式极大的简化了原来阴阳历转换的代码。

### CBLunarUtil接口
```
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
@end
```

### DateUtils接口
```

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
 获取月份英文简称

 @param date date description
 @return return value description
 */
+(NSString *)getMonthKeyStrWith:(NSDate *)date;


/**
 获取周几的英文简称

 @param date date description
 @return return value description
 */
+(NSString *)getWeekKeyStrWith:(NSDate *)date;

/**
 日期去掉时分秒
 
 @param inputDate 日期
 @return return date
 */
+(NSDate *)dateToDay:(NSDate *)inputDate;

@end

```
