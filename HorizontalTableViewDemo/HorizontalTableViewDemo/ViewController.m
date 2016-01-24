//
//  ViewController.m
//  HorizontalTableViewDemo
//
//  Created by Babytree on 16/1/24.
//  Copyright © 2016年 HKZ. All rights reserved.
//

#import "ViewController.h"
#import "HKHorizontalTableView.h"
#import "CustomCell.h"

@interface ViewController ()<HKHorizontalTableViewDataSource,HKHorizontalTableViewDelegate>
{
    CGFloat _cellWith;
}
@property (nonatomic, strong) NSMutableArray *m_horizontalData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellWith = 100;
    self.m_horizontalData = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8", nil];
    
    HKHorizontalTableView *table = [[HKHorizontalTableView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 120)];
    table.tag = 999;
    table.pagingEnabled = YES;
    table.pageWith = _cellWith;
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
    [table reloadData];
}

#pragma - mark HKTable delegate

- (CGFloat)HKHorizontalTableView:(HKHorizontalTableView *)hTableView widthForColumn:(NSInteger)index
{
    return _cellWith;
}

-(NSInteger)numberOfColumnsForHKHorizontalTableView:(HKHorizontalTableView *)hTableView
{
    return self.m_horizontalData.count;
}

-(UIView *)HKHorizontalTableView:(HKHorizontalTableView *)hTableView viewForColumn:(NSInteger)index viewFrame:(CGRect)viewFrame
{
    CustomCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil] lastObject];
    cell.userInteractionEnabled = NO; // 需要置为NO，否则会覆盖Tableviewcell的点击事件
    cell.m_ImgView.contentMode = UIViewContentModeScaleToFill;
    cell.frame = viewFrame;
    return cell;
}

-(void)HKHorizontalTableView:(HKHorizontalTableView *)hTableView setContentView:(UIView *)contentView ForIndex:(NSInteger)index{
    CustomCell *cell = (CustomCell *)contentView;
    cell.m_ImgView.image = [UIImage imageNamed:@"kk.jpg"];
    
    cell.m_TitleLabel.text = self.m_horizontalData[index];
}

-(void)HKHorizontalTableView:(HKHorizontalTableView *)hTableView didSelectColumn:(NSInteger)index
{
    NSLog(@"selected !!");
    [self.m_horizontalData replaceObjectAtIndex:index withObject:@"get"];
    HKHorizontalTableView *table = [self.view viewWithTag:999];
    [table reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
