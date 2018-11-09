//
//  CYRecorderVC.m
//  UIOne
//
//  Created by SaturdayNight on 2018/1/30.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CYRecorderVC.h"

@interface CYRecorderVC ()

@property (nonatomic,strong) UIButton *btnBeginRecord;
@property (nonatomic,strong) UIButton *btnPauseRecord;
@property (nonatomic,strong) UIButton *btnStopRecord;

@end

@implementation CYRecorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"录音";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btnBeginRecord];
}

#pragma mark - Event Action
#pragma mark  开始录音
-(void)btnBeginRecordClicked:(UIButton *)btn
{
    
}

#pragma mark 暂停录音
-(void)btnPauseRecordClicked:(UIButton *)btn
{
    
}

#pragma mark 停止录音
-(void)btnStopRecordClicked:(UIButton *)btn
{
    
}

#pragma mark - LazyLoad
-(UIButton *)btnBeginRecord
{
    if (!_btnBeginRecord) {
        _btnBeginRecord = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnBeginRecord setTitle:@"开始" forState:UIControlStateNormal];
        [_btnBeginRecord addTarget:self action:@selector(btnBeginRecordClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnBeginRecord;
}

-(UIButton *)btnPauseRecord
{
    if (!_btnPauseRecord) {
        _btnPauseRecord = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnPauseRecord setTitle:@"暂停" forState:UIControlStateNormal];
        [_btnPauseRecord addTarget:self action:@selector(btnPauseRecordClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnPauseRecord;
}

-(UIButton *)btnStopRecord
{
    if (!_btnStopRecord) {
        _btnStopRecord = [UIButton buttonWithType:UIButtonTypeSystem];
        [_btnStopRecord setTitle:@"停止" forState:UIControlStateNormal];
        [_btnStopRecord addTarget:self action:@selector(btnStopRecordClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btnStopRecord;
}

@end
