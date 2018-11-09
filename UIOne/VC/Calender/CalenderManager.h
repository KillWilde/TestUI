//
//  CalenderManager.h
//  UIOne
//
//  Created by SaturdayNight on 2018/1/26.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenderManager : NSObject

#pragma mark 获取传入日期 所对应的WeekDayNum 1表示星期天 2表示星期一 以此类推
+(NSInteger)getWeekdayNumWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

#pragma mark 获取传入日期 所对应的礼拜几
+(NSString *)getWeekdayStrWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

#pragma mark - 获取某一月的天数
+(NSInteger)getDaysWithYear:(NSInteger)year month:(NSInteger)month;

@end
