//
//  CustomCell.m
//  HorizontalTableViewDemo
//
//  Created by Babytree on 16/1/24.
//  Copyright © 2016年 HKZ. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    self.m_ImgView.clipsToBounds = YES;
    self.m_ImgView.layer.cornerRadius = 20;
    self.m_ImgView.layer.borderColor = [UIColor blackColor].CGColor;
    self.m_ImgView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
