//
//  CalenderNumberCell.h
//  UIOne
//
//  Created by SaturdayNight on 2018/1/26.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CalendarSelectedStyle) {
    CalendarSelectedStyle_Normal,
    CalendarSelectedStyle_Orange,
    CalendarSelectedStyle_Blue
};

@interface CalenderNumberCell : UICollectionViewCell

@property (nonatomic,strong) UILabel *lbTitle;

-(void)makeSelectedStyle:(CalendarSelectedStyle)style;

@end
