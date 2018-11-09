//
//  CYCalenderVC.m
//  UIOne
//
//  Created by SaturdayNight on 2018/1/25.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CYCalenderVC.h"
#import "CYCalenderView.h"
#import <Masonry.h>

@interface CYCalenderVC ()

@property (nonatomic,strong) CYCalenderView *calanderView;

@end

@implementation CYCalenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"日历";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.calanderView];
    
    [self myLayout];
}

#pragma mark - Layout
-(void)myLayout
{
    [self.calanderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(64);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - LazyLoad
-(CYCalenderView *)calanderView
{
    if (!_calanderView) {
        _calanderView = [[CYCalenderView alloc] initWithFrame:CGRectZero];
    }
    
    return _calanderView;
}

@end
