//
//  TTCustomCollectionCell.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "TTCustomCollectionCell.h"

@implementation TTCustomCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
        
        _city_button = [UIButton buttonWithType:(UIButtonTypeRoundedRect)];
        [_city_button addTarget:self action:@selector(buttonDidiClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview:_city_button];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = self.contentView.bounds;
    _titleLabel.textColor = rgb(73, 73, 73);
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.layer.borderColor = rgb(207, 207, 207).CGColor;
    _titleLabel.layer.borderWidth = 0.8;
    _titleLabel.layer.cornerRadius = 5.0;
    _titleLabel.layer.masksToBounds = YES;
    
    _city_button.frame = self.contentView.bounds;
    _city_button.tintColor = rgb(73, 73, 73);
    _city_button.backgroundColor = [UIColor orangeColor];
    _city_button.layer.borderColor = rgb(207, 207, 207).CGColor;
    _city_button.layer.borderWidth = 0.8;
    _city_button.layer.cornerRadius = 5.0;
    _city_button.layer.masksToBounds = YES;
}

-(void)setSelected:(BOOL)selected
{
    if (selected) {
        _city_button.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _city_button.layer.borderColor = rgb(25, 182, 158).CGColor;
        _city_button.layer.borderWidth = 0.8;
        _city_button.layer.cornerRadius = 5.0;
    }else
    {
        _city_button.backgroundColor = [UIColor whiteColor];
        _city_button.layer.borderColor = rgb(207, 207, 207).CGColor;
        _city_button.layer.borderWidth = 0.8;
        _city_button.layer.cornerRadius = 5.0;
    }
}

#pragma mark - ----------------------------Triggering method----------------------------
- (void)buttonDidiClick:(id)sender{
    if ([_delegate respondsToSelector:@selector(sendButtonClick:)]) {
        [_delegate sendButtonClick:_indexpath];
    }
}
@end
