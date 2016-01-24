//
//  HKHorizontalTableView.m
//  HorizontalTableViewDemo
//
//  Created by Babytree on 16/1/24.
//  Copyright © 2016年 HKZ. All rights reserved.
//

#import "HKHorizontalTableView.h"

#import <QuartzCore/QuartzCore.h>

#define CUSTOM_CELL_TAG      1024

@interface HKHorizontalTableView ()
<
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate
>
{
    CGSize _size;
}

@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation HKHorizontalTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _size = frame.size;
        _pageWith = [[UIScreen mainScreen] bounds].size.width;
        [self addSubview:self.tableView];
    }
    return self;
}

#pragma mark - Private Method

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _size.width, _size.height)];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.frame = CGRectMake(0, 0, _size.width, _size.height);
    }
    return _tableView;
}

#pragma mark - Public Method

- (void)reloadData{
    [self.tableView reloadData];
}

-(void)setBounces:(BOOL)bounces
{
    if (_bounces != bounces) {
        _bounces = bounces;
        self.tableView.bounces = bounces;
    }
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        if (self.pagingEnabled) {
            [self stopOnMultiplesOfViewBounds:scrollView];
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.pagingEnabled) {
        [self stopOnMultiplesOfViewBounds:scrollView];
    }
}

- (void)stopOnMultiplesOfViewBounds:(UIScrollView *)scrollView
{
    CGFloat offsetY;
    
    CGFloat horizontalOffset = scrollView.contentOffset.y;
    CGFloat trailingOffset = scrollView.contentSize.height-horizontalOffset-_size.width;
    
    if (trailingOffset < self.pageWith/2) {
        offsetY = scrollView.contentSize.height-_size.width;
    }else{
        NSInteger mod = (NSInteger)horizontalOffset%(NSInteger)self.pageWith;
        NSInteger pageCount = horizontalOffset/self.pageWith;
        if (mod < self.pageWith/2) {
            offsetY  = self.pageWith*pageCount;
        }else{
            offsetY = self.pageWith*(pageCount+1);
        }
    }
    
    CGPoint tableOffset = CGPointMake(0, offsetY);
    [self.tableView setContentOffset:tableOffset animated:YES];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataSource respondsToSelector:@selector(HKHorizontalTableView:widthForColumn:)]) {
        return [self.dataSource HKHorizontalTableView:self widthForColumn:indexPath.row];
    }
    else {
        return 0.f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.dataSource respondsToSelector:@selector(numberOfColumnsForHKHorizontalTableView:)]) {
        return [self.dataSource numberOfColumnsForHKHorizontalTableView:self];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"HorizontalTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.frame = CGRectMake(0, 0, [self.dataSource HKHorizontalTableView:self widthForColumn:indexPath.row], _size.height);
        cell.contentView.frame = cell.bounds;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *contentView = [self.dataSource HKHorizontalTableView:self viewForColumn:indexPath.row viewFrame:cell.contentView.frame];
        if (!contentView) {
            contentView = [[UIView alloc] initWithFrame:cell.contentView.bounds];
        }
        contentView.transform = CGAffineTransformMakeRotation(M_PI/2);
        contentView.frame = CGRectMake(0, 0, cell.contentView.frame.size.height, cell.contentView.frame.size.width);
        contentView.tag = CUSTOM_CELL_TAG;
        [cell.contentView addSubview:contentView];
    }
    
    UIView *contentView = [cell.contentView viewWithTag:CUSTOM_CELL_TAG];
    [self.dataSource HKHorizontalTableView:self setContentView:contentView ForIndex:indexPath.row];
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(HKHorizontalTableView:didSelectColumn:)]) {
        [self.delegate HKHorizontalTableView:self didSelectColumn:indexPath.row];
    }
}

@end

