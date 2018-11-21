//
//  CYCalendarHorizontalView.m
//  UIOne
//
//  Created by Tony Stark on 2018/11/9.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "CYCalendarHorizontalView.h"
#import <Masonry.h>
#import "MonthTitleCell.h"
#import "CalendarDayCell.h"

static NSString *const kMonthTitleCell = @"kMonthTitleCell";
static NSString *const kCalendarDayCell = @"kCalendarDayCell";

@interface CYCalendarHorizontalView () <UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) MonthTitleCell *scaleCell;             // 用于控制放大和缩小
@property (nonatomic,assign) CGFloat itemNum;                       // 屏幕可以放置月份item的个数
@property (nonatomic,strong) UICollectionView *listViewMonth;       // list show aviliable month

@property (nonatomic,strong) NSMutableArray *listMonthDataSource;   // 具体需要展示的月份数据源
@property (nonatomic,strong) UICollectionView *listViewDay;

@property (nonatomic,copy) NSString *curChoseDateStr;               // 当前选中的日期
@property (nonatomic,assign) NSInteger lastIndexRow;                // 最后滑动的序号 根据这个计算滑动到的日期 再去滑动月份

@end

@implementation CYCalendarHorizontalView

-(CYCalendarHorizontalView *)initWithFrame:(CGRect)rect
{
    self = [super initWithFrame:rect];
    if (self) {
        self.sYear = 2018;
        self.eYear = 2018;
        self.itemNum = [self getCurentSupportWidth];
        
        [self addSubview:self.listViewMonth];
        [self addSubview:self.listViewDay];
        
        [self myLayout];
    }
    
    return self;
}

// 监听滑动后的年月日结果
- (void)listenDateYMChosed:(CalendarYearAndMonthChosed)choseAction{
    self.choseDateYM = choseAction;
}

// 滚动到对应的年月日 格式标准YYYY-MM
- (void)choseDate:(NSString *)dateStr animationed:(BOOL)animation{
    NSArray *arrayInfo = [dateStr componentsSeparatedByString:@"-"];
    if (arrayInfo && arrayInfo.count >= 2) {
        int year = [[arrayInfo objectAtIndex:0] intValue];
        int month = [[arrayInfo objectAtIndex:1] intValue];
        int i = (year - self.sYear) * 12 + month + self.itemNum;
        CGFloat tempItemWidth = SCREEN_WIDTH / self.itemNum;
        [self.listViewMonth setContentOffset:CGPointMake(((i - 1) * tempItemWidth) + tempItemWidth * 0.5 - 0.5 * SCREEN_WIDTH, 0) animated:animation];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 101) {
        return self.listMonthDataSource.count;
    }
    else{
        return (self.eYear - self.sYear + 1) * 12;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 101) {
        MonthTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMonthTitleCell forIndexPath:indexPath];
        int num = [[_listMonthDataSource objectAtIndex:indexPath.row] intValue];
        NSString *strMonth;
        if (num == 0) {
            strMonth = @"";
        }
        else{
            strMonth = [NSString stringWithFormat:@"%i%@",num,@"月"];
        }
        
        cell.tag = indexPath.row;
        cell.lbTitle.text = strMonth;
        cell.lbTitle.textColor = [UIColor colorWithRed:126/255.0 green:129/255.0 blue:135/255.0 alpha:1];
        cell.lbTitle.font = [UIFont systemFontOfSize:14 weight:1];
        
        return cell;
    }
    else{
        CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCalendarDayCell forIndexPath:indexPath];
        
        NSInteger indexRow = indexPath.row;
        self.lastIndexRow = indexRow;
        NSInteger year = (indexRow + 1) / 12 + self.sYear;
        NSInteger month = (indexRow + 1) % 12;
        if (month == 0) {
            month = 12;
            year--;
        }
        NSString *date = [NSString stringWithFormat:@"%li-%@",year,month > 9 ? [NSString stringWithFormat:@"%li",month] : [NSString stringWithFormat:@"0%li",month]];
        
        [cell showDate:date];
        
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 101) {
        if (self.scaleCell.tag != indexPath.row) {
            [self unHighlightCenterCell];
        }
        [self.listViewMonth scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 101) {
        [self keepItemCenter:scrollView];
        [self highlightCenterCell];
    }
    else{
        [self.listViewDay reloadData];
        
        CGFloat offsetNum = (NSInteger)(self.listViewDay.contentOffset.x / SCREEN_WIDTH);
        // 防止4舍5入出错
        if (((int)(offsetNum * 10)) % 10 > 0 ) {
            offsetNum = offsetNum + 1;
        }
        
        NSInteger year = ((int)offsetNum + 1) / 12 + self.sYear;
        NSInteger month = ((int)offsetNum + 1) % 12;
        if (month == 0) {
            month = 12;
            year--;
        }
        NSString *date = [NSString stringWithFormat:@"%li-%@",year,month > 9 ? [NSString stringWithFormat:@"%li",month] : [NSString stringWithFormat:@"0%li",month]];
        
        [self choseDate:date animationed:YES];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView.tag == 101) {
        if (!decelerate) {
            [self keepItemCenter:scrollView];
            [self highlightCenterCell];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.tag == 101) {
        [self keepItemCenter:scrollView];
        [self highlightCenterCell];
        
        NSInteger indexRow = self.scaleCell.tag;
        NSInteger year = (indexRow - self.itemNum + 1) / 12 + self.sYear;
        NSInteger month = (indexRow - (int)self.itemNum + 1) % 12;
        if (month == 0) {
            month = 12;
            year--;
        }
        
        NSString *date = [NSString stringWithFormat:@"%li-%@",year,month > 9 ? [NSString stringWithFormat:@"%li",month] : [NSString stringWithFormat:@"0%li",month]];
        self.curChoseDateStr = date;
        if (self.choseDateYM) {
            self.choseDateYM(date);
        }
        
        // 根据中心点的cell对应的年月计算 listDay需要滑动的位置并滑动
        NSInteger destIndexRow = (year - self.sYear) * 12 + month - 1;
        NSIndexPath *destIndexPath = [NSIndexPath indexPathForRow:destIndexRow inSection:0];
        [self.listViewDay scrollToItemAtIndexPath:destIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    else{
        [self.listViewDay reloadData];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView.tag == 101) {
        [self unHighlightCenterCell];
    }
}

- (void)keepItemCenter:(UIScrollView *)scrollView{
    CGFloat tempItemWidth = SCREEN_WIDTH / self.itemNum;
    CGFloat destOffset = 0;
    if (scrollView.contentOffset.x < SCREEN_WIDTH / 2.0) {
        destOffset = SCREEN_WIDTH / 2.0 + tempItemWidth * 0.5;
        [scrollView setContentOffset:CGPointMake(destOffset, 0) animated:YES];
    }
    else if (scrollView.contentOffset.x > ((self.eYear - self.sYear + 1) * tempItemWidth * 12 + 1 * SCREEN_WIDTH) - SCREEN_WIDTH * 0.5){
        destOffset = ((self.eYear - self.sYear + 1) * tempItemWidth * 12 + 1 * SCREEN_WIDTH) - SCREEN_WIDTH * 0.5 - tempItemWidth * 0.5;
        [scrollView setContentOffset:CGPointMake(destOffset, 0) animated:YES];
    }
    else{
        for (int i = 0; i < self.listMonthDataSource.count; i ++) {
            if ((scrollView.contentOffset.x + 0.5 * SCREEN_WIDTH - tempItemWidth * i) > tempItemWidth) {
                continue;
            }
            else{
                destOffset = (i * tempItemWidth) + tempItemWidth * 0.5 - 0.5 * SCREEN_WIDTH;
                [scrollView setContentOffset:CGPointMake(destOffset, 0) animated:YES];
                break;
            }
        }
    }
    
    [self unHighlightCenterCell];
    self.scaleCell = [self getCenterCellOffset:destOffset];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 101) {
        return CGSizeMake(SCREEN_WIDTH / self.itemNum , 35);
    }
    
    return CGSizeMake(SCREEN_WIDTH, 400);
}

#pragma mark - 通过中心点计算
#pragma mark - Layout
- (void)myLayout{
    [self.listViewMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@40);
    }];
    
    [self.listViewDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self.listViewMonth.mas_bottom);
        make.height.equalTo(@400);
    }];
}

#pragma mark - LazyLoad
- (NSMutableArray *)listMonthDataSource{
    if (!_listMonthDataSource) {
        _listMonthDataSource = [NSMutableArray arrayWithCapacity:0];
        for (NSInteger i = self.sYear; i <= self.eYear; i ++) {
            for (int m = 1; m < 13; m ++) {
                [_listMonthDataSource addObject:[NSNumber numberWithInt:m]];
            }
        }
        
        // 考虑到需要滑动到边界 要在左右各加上空白的个数
        NSMutableArray *leftArr = [NSMutableArray arrayWithCapacity:0];
        NSMutableArray *rightArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < self.itemNum; i ++) {
            [leftArr addObject:[NSNumber numberWithInt:0]];
            [rightArr addObject:[NSNumber numberWithInt:0]];
        }
        
        [leftArr addObjectsFromArray:_listMonthDataSource];
        [leftArr addObjectsFromArray:rightArr];
        _listMonthDataSource = [leftArr mutableCopy];
    }
    
    return _listMonthDataSource;
}

- (UICollectionView *)listViewMonth{
    if (!_listViewMonth) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(35,35);
        
        _listViewMonth = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _listViewMonth.tag = 101;
        _listViewMonth.dataSource = self;
        _listViewMonth.delegate = self;
        _listViewMonth.backgroundColor = CY_GET_UICOLOR(31, 41, 54, 1);
        [_listViewMonth registerClass:[MonthTitleCell class] forCellWithReuseIdentifier:kMonthTitleCell];
    }
    
    return _listViewMonth;
}

- (UICollectionView *)listViewDay{
    if (!_listViewDay) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(35,35);
        
        _listViewDay = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _listViewDay.tag = 102;
        _listViewDay.dataSource = self;
        _listViewDay.delegate = self;
        _listViewDay.pagingEnabled = YES;
        _listViewDay.showsVerticalScrollIndicator = NO;
        _listViewDay.showsHorizontalScrollIndicator = NO;
        _listViewDay.backgroundColor = [UIColor whiteColor];
        
        [_listViewDay registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:kCalendarDayCell];
    }
    
    return _listViewDay;
}

#pragma mark - 计算屏幕中可以放置月份item的个数 宽度限制一下至少要大于一定长度
static const int minWidth = 70;
- (CGFloat)getCurentSupportWidth{
    for (float item = 40.0; item > 0; item --) {
        if (SCREEN_WIDTH / item >= minWidth) {
            return item;
        }
    }
    
    return 12;
}

#pragma mark - 标记中心cell
- (void)highlightCenterCell{
    self.scaleCell.lbTitle.font = [UIFont systemFontOfSize:18 weight:2];
    self.scaleCell.lbTitle.textColor = [UIColor whiteColor];
}

- (void)unHighlightCenterCell{
    self.scaleCell.lbTitle.font = [UIFont systemFontOfSize:14 weight:1];
    self.scaleCell.lbTitle.textColor = [UIColor colorWithRed:126/255.0 green:129/255.0 blue:135/255.0 alpha:1];
}

#pragma mark - 获取中心cell
- (MonthTitleCell *)getCenterCellOffset:(CGFloat)offset{
    NSInteger row = [self getCenterCellIndexRowWithContenOffset:offset];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    MonthTitleCell *cell = (MonthTitleCell *)[self.listViewMonth cellForItemAtIndexPath:indexPath];
    
    return cell;
}

#pragma mark - 获取中心cell的序号
- (NSInteger)getCenterCellIndexRowWithContenOffset:(CGFloat)offset{
    CGFloat tempWidth = SCREEN_WIDTH / self.itemNum;
    CGFloat total = (offset - (0.5 * SCREEN_WIDTH + 0.5 * tempWidth)) / tempWidth;
    // 防止4舍5入出错
    if (((int)(total * 10)) % 10 > 0 ) {
        total = total + 1;
    }
    NSInteger row = (NSInteger)(total) + self.itemNum;
    
    return row;
}

@end


