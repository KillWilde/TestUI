//
//  ChoseListVC.m
//  UIOne
//
//  Created by Megatron on 2019/7/15.
//  Copyright © 2019 SaturdayNight. All rights reserved.
//

#import "ChoseListVC.h"
#import <Masonry.h>
#import "HitTestTableView.h"

@class ChoseListVCCell;

@protocol ChoseListVCCellDelegate <NSObject>

- (void)choseListCellChoseButtonClickIndex:(int)row cell:(ChoseListVCCell *)cell;

@end

@interface ChoseListVCCell : UITableViewCell <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *btnChose;
@property (nonatomic,strong) UITableView *tbList;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) int selectedIndex;

@property (nonatomic,assign) int row;
@property (nonatomic,assign) int section;
@property (nonatomic,weak) id<ChoseListVCCellDelegate>delegate;

- (void)hideList;

@end

@implementation ChoseListVCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.btnChose];
        [self addSubview:self.tbList];
        
        [self.btnChose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@40);
            make.right.equalTo(self).mas_offset(-15);
            make.centerY.equalTo(self);
        }];
        
        [self.tbList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.btnChose);
            make.height.equalTo(@0);
            make.right.equalTo(self.btnChose);
            make.bottom.equalTo(self.btnChose.mas_top);
        }];
    }
    
    return self;
}

//MARK: - EventAction
- (void)btnChoseClicked{
    [self changeListHideState];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(choseListCellChoseButtonClickIndex:cell:)]) {
        [self.delegate choseListCellChoseButtonClickIndex:self.row cell:self];
    }
}

//MARK: 隐藏显示下拉框
- (void)showList{
    CGFloat height = 200;
    if (self.dataSource.count < 5) {
        height = 40 * self.dataSource.count;
    }
    
    self.tbList.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        [self.tbList mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.btnChose);
            make.height.mas_equalTo(height);
            make.right.equalTo(self.btnChose);
            make.bottom.equalTo(self.btnChose.mas_top);
        }];
    }];
}

- (void)hideList{
    [UIView animateWithDuration:0.3 animations:^{
        [self.tbList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.btnChose);
            make.height.equalTo(@0);
            make.right.equalTo(self.btnChose);
            make.bottom.equalTo(self.btnChose.mas_top);
        }];
        
        self.tbList.hidden = YES;
    }];
}

- (void)changeListHideState{
    if (self.tbList.hidden) {
        [self showList];
    }else{
        [self hideList];
    }
}

//MARK: - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kUITableViewCell"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = [self.dataSource objectAtIndex:indexPath.row];
    NSLog(@"点击了 第%i行 %@",(int)indexPath.row,name);
    [self.btnChose setTitle:name forState:UIControlStateNormal];
    
    [self changeListHideState];
}

//MARK: - LazyLoad
- (UITableView *)tbList{
    if (!_tbList) {
        _tbList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _tbList.layer.cornerRadius = 5;
        _tbList.layer.masksToBounds = YES;
        _tbList.layer.borderColor = [UIColor grayColor].CGColor;
        _tbList.layer.borderWidth = 1;
        _tbList.hidden = YES;
        _tbList.rowHeight = 40;
        [_tbList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kUITableViewCell"];
        
        _tbList.delegate = self;
        _tbList.dataSource = self;
    }
    
    return _tbList;
}

- (UIButton *)btnChose{
    if (!_btnChose) {
        _btnChose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnChose setTitle:@"未选择" forState:UIControlStateNormal];
        [_btnChose addTarget:self action:@selector(btnChoseClicked) forControlEvents:UIControlEventTouchUpInside];
        _btnChose.layer.cornerRadius = 3;
        _btnChose.layer.masksToBounds = YES;
        _btnChose.layer.borderWidth = 1;
        _btnChose.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    return _btnChose;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithObjects:@"一级",@"二级",@"三级",@"四级",@"五级",@"六级", nil];
    }
    
    return _dataSource;
}

@end

@interface ChoseListVC () <UITableViewDelegate,UITableViewDataSource,ChoseListVCCellDelegate>

@property (nonatomic,strong) HitTestTableView *tableView;

@end

static NSString *const kChoseListVCCell = @"kChoseListVCCell";

@implementation ChoseListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    self.tableView = [[HitTestTableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 50;
    self.tableView.clipsToBounds = NO;
    
    [self.tableView registerClass:[ChoseListVCCell class] forCellReuseIdentifier:kChoseListVCCell];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
}

- (void)btnClicked:(UIButton *)sender{
    int r = arc4random()%255;
    int g = arc4random()%255;
    int b = arc4random()%255;
    
    [sender setBackgroundColor:[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]];
}

//MAKR: Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChoseListVCCell *cell = [tableView dequeueReusableCellWithIdentifier:kChoseListVCCell];
    
    cell.delegate = self;
    cell.textLabel.text = @"选择模式";
    [cell hideList];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.tableView reloadData];
}

- (void)choseListCellChoseButtonClickIndex:(int)row cell:(id)cell{
    [self.tableView bringSubviewToFront:cell];
}

@end


