//
//  CYCalenderView.h
//  UIOne
//
//  Created by SaturdayNight on 2018/1/25.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYCalenderView : UIView

@property (nonatomic,assign) NSInteger sYear;

@property (nonatomic,assign) NSInteger eYear;


-(CYCalenderView *)initWithFrame:(CGRect)rect;

@end
