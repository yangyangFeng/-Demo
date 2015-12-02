//
//  TTCustomCell.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "TTCustomCell.h"

@implementation TTCustomCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _logo = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_logo];
    }
    return self;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _logo = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_logo];
    }
    return self;
}
-(void)awakeFromNib{
    
    [super awakeFromNib];

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    _logo.frame = CGRectMake(20, 0, self.contentView.height, self.contentView.height);
    _logo.layer.cornerRadius = self.contentView.height / 2.0;
    _logo.layer.masksToBounds = YES;
}
@end
