//
//  CalendarDayCell.m
//  UIOne
//
//  Created by Tony Stark on 2018/11/20.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CalendarDayCell.h"
#import "CalenderNumberCell.h"
#import <Masonry.h>
#import "CalenderManager.h"

static NSString *const kListWeekCell = @"CalenderNumberCell";
static NSString *const kListMonthCell = @"Month";

@interface CalendarDayCell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UILabel *lbData;   // 日期 年：月：日
@property (nonatomic,strong) UICollectionView *listWeek;    // 星期列表
@property (nonatomic,strong) NSArray *arrayListWeek;        // 星期数据

@property (nonatomic,strong) UICollectionView *listMonth;   // 月份列表
@property (nonatomic,strong) NSMutableArray *arrayListMonth; // 月份详细

@end

@implementation CalendarDayCell

- (instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.listWeek];
        [self addSubview:self.listMonth];
        
        [self myLayout];
    }
    
    return self;
}

#pragma mark - 参数格式 YYYY-MM
- (void)showDate:(NSString *)date{
    [self updateDateSourceFrom:date];
    [self.listMonth reloadData];
}

#pragma makr - UpdateShowDateSource
- (void)updateDateSourceFrom:(NSString *)date{
    NSArray *arrInfo = [date componentsSeparatedByString:@"-"];
    if (arrInfo.count >= 2) {
        int year = [[arrInfo objectAtIndex:0] intValue];
        int month = [[arrInfo objectAtIndex:1] intValue];
        
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithCapacity:0];
        
        NSInteger num = [CalenderManager getWeekdayNumWithYear:year month:month day:1];
        NSInteger totalDays = [CalenderManager getDaysWithYear:year month:month];
        
        NSString *title = [NSString stringWithFormat:@"%i年%i月",year,month];
        
        [dicInfo setObject:[NSNumber numberWithInteger:num] forKey:@"FirstWeekdayNum"];
        [dicInfo setObject:[NSNumber numberWithInteger:totalDays] forKey:@"TotalDays"];
        [dicInfo setObject:title forKey:@"Title"];
        
        [self.arrayListMonth replaceObjectAtIndex:0 withObject:dicInfo];
    }
}

#pragma mark - Delegate
#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 101) {
        
    }
    else{
        
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 101) {
        return 1;
    }
    else
    {
        return 1;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 101) {
        return self.arrayListWeek.count;
    }
    else
    {
        return 42 + 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 101) {
        CalenderNumberCell *cell = (CalenderNumberCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kListWeekCell forIndexPath:indexPath];
        
        cell.lbTitle.text = [NSString stringWithFormat:@"%@",[self.arrayListWeek objectAtIndex:indexPath.row]];
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.lbTitle.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        return cell;
    }
    else
    {
        CalenderNumberCell *cell = (CalenderNumberCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kListMonthCell forIndexPath:indexPath];
        
        NSDictionary *dic = self.arrayListMonth[indexPath.section];
        
        [cell makeSelectedStyle:CalendarSelectedStyle_Normal];
        cell.hidden = NO;
        if (indexPath.row == 0) {
            cell.hidden = YES;
            //cell.lbTitle.text = [dic objectForKey:@"Title"];
        }
        else
        {
            NSInteger firstWeekdayNum = [[dic objectForKey:@"FirstWeekdayNum"] integerValue];
            NSInteger totalDays = [[dic objectForKey:@"TotalDays"] integerValue];
            
            if (firstWeekdayNum > indexPath.row || (totalDays + firstWeekdayNum
                                                    - 1) < indexPath.row ) {
                cell.lbTitle.text = @"";
            }
            else
            {
                cell.lbTitle.text = [NSString stringWithFormat:@"%li",indexPath.row - firstWeekdayNum + 1];
            }
            
            if (firstWeekdayNum == indexPath.row) {
                [cell makeSelectedStyle:CalendarSelectedStyle_Orange];
            }

        }
        
        return cell;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 101) {
        return CGSizeMake(self.frame.size.width / (self.arrayListWeek.count * 1.0), 35);
    }
    else
    {
        if (indexPath.row == 0) {
            return CGSizeMake(self.frame.size.width, 0);
        }
        else
        {
            return CGSizeMake(self.frame.size.width / (self.arrayListWeek.count * 1.0) - 1, 50);
        }
    }
}

#pragma mark - Layout
-(void)myLayout
{
    [self.listWeek mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@35);
    }];
    
    [self.listMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.listWeek.mas_bottom);
        make.bottom.equalTo(self);
    }];
}

#pragma mark - LazyLoad
-(UILabel *)lbData
{
    if (!_lbData) {
        _lbData = [[UILabel alloc] init];
    }
    
    return _lbData;
}

-(UICollectionView *)listWeek
{
    if (!_listWeek) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(35, 35);
        
        _listWeek = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _listWeek.tag = 101;
        _listWeek.backgroundColor = [UIColor whiteColor];
        _listWeek.showsVerticalScrollIndicator = NO;
        [_listWeek registerClass:[CalenderNumberCell class] forCellWithReuseIdentifier:kListWeekCell];
        _listWeek.dataSource = self;
        _listWeek.delegate = self;
    }
    
    return _listWeek;
}

-(NSArray *)arrayListWeek
{
    if (!_arrayListWeek) {
        _arrayListWeek = [NSArray arrayWithObjects:@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    }
    
    return _arrayListWeek;
}

-(UICollectionView *)listMonth
{
    if (!_listMonth) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(35, 35);
        
        _listMonth = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _listMonth.tag = 102;
        _listMonth.backgroundColor = [UIColor whiteColor];
        _listMonth.showsVerticalScrollIndicator = NO;
        [_listMonth registerClass:[CalenderNumberCell class] forCellWithReuseIdentifier:kListMonthCell];
        _listMonth.dataSource = self;
        _listMonth.delegate = self;
    }
    
    return _listMonth;
}

-(NSMutableArray *)arrayListMonth
{
    if (!_arrayListMonth) {
        _arrayListMonth = [NSMutableArray arrayWithCapacity:0];
        
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithCapacity:0];
        
        NSInteger num = [CalenderManager getWeekdayNumWithYear:2018 month:1 day:1];
        NSInteger totalDays = [CalenderManager getDaysWithYear:2018 month:1];
        
        NSString *title = [NSString stringWithFormat:@"%i年%i月",2018,1];
        
        [dicInfo setObject:[NSNumber numberWithInteger:num] forKey:@"FirstWeekdayNum"];
        [dicInfo setObject:[NSNumber numberWithInteger:totalDays] forKey:@"TotalDays"];
        [dicInfo setObject:title forKey:@"Title"];
        
        [_arrayListMonth addObject:dicInfo];
        
    }
    
    return _arrayListMonth;
}

@end

