//
//  CalenderNumberCell.m
//  UIOne
//
//  Created by SaturdayNight on 2018/1/26.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CalenderNumberCell.h"
#import <Masonry.h>

@interface CalenderNumberCell ()

@property (nonatomic,strong) UIView *selectedView;  // 选中状态视图

@end

@implementation CalenderNumberCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.selectedView];
        [self.contentView addSubview:self.lbTitle];
        
        [self myLayout];
    }
    
    return self;
}

#pragma mark - Event
-(void)makeSelectedStyle:(CalendarSelectedStyle)style
{
    if (style == CalendarSelectedStyle_Normal) {
        self.selectedView.backgroundColor = [UIColor clearColor];
        self.lbTitle.textColor = CY_GET_UICOLOR(120, 120, 120, 1);
    }
    else if (style == CalendarSelectedStyle_Blue)    {
        self.selectedView.backgroundColor = CY_GET_UICOLOR(110, 165, 255, 1);
        self.lbTitle.textColor = [UIColor whiteColor];
    }
    else{
        self.selectedView.backgroundColor = CY_GET_UICOLOR(242, 117, 34, 1);
        self.lbTitle.textColor = [UIColor whiteColor];
    }
}

#pragma mark - Layout
-(void)myLayout
{
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self);
        make.height.mas_equalTo(60);
    }];
    
    [self.selectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark - LazyLoad
-(UILabel *)lbTitle
{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
    }
    
    return _lbTitle;
}

-(UIView *)selectedView
{
    if (!_selectedView) {
        _selectedView = [[UIView alloc] init];
        _selectedView.layer.cornerRadius = 15;
        _selectedView.layer.masksToBounds = YES;
    }
    
    return _selectedView;
}

@end
