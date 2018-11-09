//
//  MainVC.m
//  UIOne
//
//  Created by SaturdayNight on 2018/1/25.
//  Copyright © 2018年 SaturdayNight. All rights reserved.
//

#import "MainVC.h"
#import <Masonry.h>
#import "CYCalenderVC.h"
#import "CYRecorderVC.h"

@interface MainVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *functionList;
@property (nonatomic,strong) NSMutableArray *arrayFunctions;

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主要功能";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.functionList];
    
    [self cyLayout];
}

#pragma mark - Delegate
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cmd = self.arrayFunctions[indexPath.row];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:bar];
    if ([cmd isEqualToString:@"日历"]) {
        [self.navigationController pushViewController:[[CYCalenderVC alloc] init] animated:YES];
    }
    else if ([cmd isEqualToString:@"录音"])
    {
        [self.navigationController pushViewController:[[CYRecorderVC alloc] init] animated:YES];
    }
    
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayFunctions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"FunctionListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = self.arrayFunctions[indexPath.row];
    
    return cell;
}

#pragma mark - Layout
-(void)cyLayout
{
    [self.functionList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

#pragma mark - LazyLoad
-(UITableView *)functionList
{
    if (!_functionList) {
        _functionList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _functionList.rowHeight = 60;
        _functionList.delegate = self;
        _functionList.dataSource = self;
    }
    
    return _functionList;
}

-(NSMutableArray *)arrayFunctions
{
    if (!_arrayFunctions) {
        _arrayFunctions = [NSMutableArray arrayWithCapacity:0];
        [_arrayFunctions addObject:@"日历"];
        [_arrayFunctions addObject:@"录音"];
    }
    
    return _arrayFunctions;
}

@end
