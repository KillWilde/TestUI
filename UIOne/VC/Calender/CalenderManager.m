//
//  CalenderManager.m
//  UIOne
//
//  Created by SaturdayNight on 2018/1/26.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CalenderManager.h"

@implementation CalenderManager

#pragma mark 获取传入日期 所对应的WeekDayNum 1表示星期天 2表示星期一 以此类推
+(NSInteger)getWeekdayNumWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM-dd";
    
    NSString *time = [NSString stringWithFormat:@"%li-%li-%li",year,month,day];
    NSDate *date = [format dateFromString:time];
    
    NSInteger num = [calendar component:NSCalendarUnitWeekday fromDate:date];
    
    return num;
}

#pragma mark 获取传入日期 所对应的礼拜几字符串
+(NSString *)getWeekdayStrWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSArray *array = [NSArray arrayWithObjects:@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期六", nil];
    NSString *weekStr = [array objectAtIndex:[self getWeekdayNumWithYear:year month:month day:day]];
    
    return weekStr;
}

#pragma mark - 获取某一月的天数
+(NSInteger)getDaysWithYear:(NSInteger)year month:(NSInteger)month
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy-MM";
    
    NSString *time = [NSString stringWithFormat:@"%li-%@",year,month > 9 ? [NSString stringWithFormat:@"%li",month] : [NSString stringWithFormat:@"0%li",month]];
    NSDate *date = [format dateFromString:time];
    
    if (date == nil) {
        return 0;
    }
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:date];
    
    return range.length;
}

@end
