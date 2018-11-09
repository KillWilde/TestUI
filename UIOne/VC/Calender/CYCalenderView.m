//
//  CYCalenderView.m
//  UIOne
//
//  Created by SaturdayNight on 2018/1/25.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CYCalenderView.h"
#import "CalenderNumberCell.h"
#import <Masonry.h>
#import "CalenderManager.h"

static NSString *const kListWeekCell = @"CalenderNumberCell";
static NSString *const kListMonthCell = @"Month";

@interface CYCalenderView () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *lbData;   // 日期 年：月：日
@property (nonatomic,strong) UICollectionView *listWeek;    // 星期列表
@property (nonatomic,strong) NSArray *arrayListWeek;        // 星期数据

@property (nonatomic,strong) UICollectionView *listMonth;   // 月份列表
@property (nonatomic,strong) NSMutableArray *arrayListMonth; // 月份详细

@end

@implementation CYCalenderView

-(CYCalenderView *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        // 设置需要显示的日历范围
        self.sYear = 2017;
        self.eYear = 2020;

        [self addSubview:self.listWeek];
        [self addSubview:self.listMonth];
        
        [self myLayout];
    }
    
    return self;
}

#pragma mark - Delegate
#pragma mark UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalenderNumberCell *cell = (CalenderNumberCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [cell makeSelected:YES];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 101) {
        return 1;
    }
    else
    {
        return self.arrayListMonth.count;
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
        cell.contentView.backgroundColor = CY_GET_UICOLOR(34, 182, 141, 1);
        cell.lbTitle.textColor = [UIColor whiteColor];
        
        return cell;
    }
    else
    {
        CalenderNumberCell *cell = (CalenderNumberCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kListMonthCell forIndexPath:indexPath];
        
        NSDictionary *dic = self.arrayListMonth[indexPath.section];
        
        [cell makeSelected:NO];
        
        if (indexPath.row == 0) {
            cell.lbTitle.text = [dic objectForKey:@"Title"];
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
                [cell makeSelected:YES];
            }
            cell.lbTitle.textColor = [UIColor blackColor];
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
            return CGSizeMake(self.frame.size.width, 50);
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
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake(35, 35);
        
        _listWeek = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _listWeek.tag = 101;
        _listWeek.backgroundColor = CY_GET_UICOLOR(34, 182, 141, 1);
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
        
        for (NSInteger year = self.sYear; year < (self.eYear + 1); year ++) {
            for (NSInteger month = 1; month < 13; month ++) {
                NSMutableDictionary *dicInfo = [NSMutableDictionary dictionaryWithCapacity:0];
                
                NSInteger num = [CalenderManager getWeekdayNumWithYear:year month:month day:1];
                NSInteger totalDays = [CalenderManager getDaysWithYear:year month:month];
                
                NSString *title = [NSString stringWithFormat:@"%li年%li月",year,month];
                
                [dicInfo setObject:[NSNumber numberWithInteger:num] forKey:@"FirstWeekdayNum"];
                [dicInfo setObject:[NSNumber numberWithInteger:totalDays] forKey:@"TotalDays"];
                [dicInfo setObject:title forKey:@"Title"];
                
                [_arrayListMonth addObject:dicInfo];
            }
        }
    }
    
    return _arrayListMonth;
}

@end
