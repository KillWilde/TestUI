//
//  CYCalendarHorizontalView.h
//  UIOne
//
//  Created by Tony Stark on 2018/11/9.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CalendarYearAndMonthChosed)(NSString *date);

@interface CYCalendarHorizontalView : UIView

@property (nonatomic,assign) int sYear;

@property (nonatomic,assign) int eYear;

@property (nonatomic,copy) CalendarYearAndMonthChosed choseDateYM;

// 监听滑动后的年月日结果
- (void)listenDateYMChosed:(CalendarYearAndMonthChosed)choseAction;

// 滚动到对应的年月日 格式标准YYYY-MM
- (void)choseDate:(NSString *)dateStr animationed:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
