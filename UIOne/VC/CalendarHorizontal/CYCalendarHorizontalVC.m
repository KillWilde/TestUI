//
//  CYCalendarHorizontalVC.m
//  UIOne
//
//  Created by Tony Stark on 2018/11/9.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CYCalendarHorizontalVC.h"
#import "CYCalendarHorizontalView.h"
#import <Masonry.h>

@interface CYCalendarHorizontalVC ()

@property (nonatomic,strong) CYCalendarHorizontalView *calendar;   


@end

@implementation CYCalendarHorizontalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.calendar];
    
    [self myLayout];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.calendar choseDate:@"2002-05" animationed:YES];
}

#pragma mark - Layout
-(void)myLayout
{
    [self.calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.left.equalTo(self.view.mas_left);
        make.height.equalTo(@350);
    }];
}

#pragma mark - LazyLoad
- (CYCalendarHorizontalView *)calendar{
    if (!_calendar) {
        _calendar = [[CYCalendarHorizontalView alloc] init];
    }
    
    return _calendar;
}

@end
