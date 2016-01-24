//
//  HKHorizontalTableView.h
//  HorizontalTableViewDemo
//
//  Created by Babytree on 16/1/24.
//  Copyright © 2016年 HKZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HKHorizontalTableViewDataSource;
@protocol HKHorizontalTableViewDelegate;

@interface HKHorizontalTableView : UIView

@property (nonatomic, assign) BOOL            bounces;
@property (nonatomic, assign) BOOL      pagingEnabled;
@property (nonatomic, assign) CGFloat        pageWith; // 默认为屏幕宽度


@property (nonatomic, weak) id<HKHorizontalTableViewDataSource>         dataSource;
@property (nonatomic, weak) id<HKHorizontalTableViewDelegate>           delegate;
//刷新视图
- (void)reloadData;

@end


@protocol HKHorizontalTableViewDataSource <NSObject>

@required

//每个子视图的宽度
- (CGFloat)HKHorizontalTableView:(HKHorizontalTableView *)hTableView widthForColumn:(NSInteger)index;

//视图的总数
- (NSInteger)numberOfColumnsForHKHorizontalTableView:(HKHorizontalTableView *)hTableView;

//为CotentView中的子视图控件重新赋值
- (void)HKHorizontalTableView:(HKHorizontalTableView *)hTableView setContentView:(UIView *)contentView ForIndex:(NSInteger)index;

// 自定义View的frame须设为viewFrame,
// 注意：如果自定义view为tableviewcell或Button，需要置为NO，否则会覆盖Tableviewcell的点击事件
- (UIView *)HKHorizontalTableView:(HKHorizontalTableView *)hTableView viewForColumn:(NSInteger)index viewFrame:(CGRect)viewFrame;
@end

@protocol HKHorizontalTableViewDelegate <NSObject>
@optional
//选中某一个视图时，触发此方法
- (void)HKHorizontalTableView:(HKHorizontalTableView *)hTableView didSelectColumn:(NSInteger)index;
@end
