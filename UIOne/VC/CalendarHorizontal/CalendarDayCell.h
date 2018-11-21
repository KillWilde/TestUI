//
//  CalendarDayCell.h
//  UIOne
//
//  Created by Tony Stark on 2018/11/20.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarDayCell : UICollectionViewCell

#pragma mark - 参数格式 YYYY-MM
- (void)showDate:(NSString *)date;

@end

NS_ASSUME_NONNULL_END
