//
//  MonthTitleCell.m
//  UIOne
//
//  Created by Tony Stark on 2018/11/12.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "MonthTitleCell.h"
#import <Masonry.h>

@implementation MonthTitleCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.lbTitle];
        
        [self myLayout];
    }
    
    return self;
}

#pragma mark - Layout
- (void)myLayout{
    [self.lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - LazyLoad
- (UILabel *)lbTitle{
    if (!_lbTitle) {
        _lbTitle = [[UILabel alloc] init];
        _lbTitle.textColor = [UIColor whiteColor];
        _lbTitle.font = [UIFont systemFontOfSize:14 weight:1];
        _lbTitle.textAlignment = NSTextAlignmentCenter;
    }
    
    return _lbTitle;
}
@end
