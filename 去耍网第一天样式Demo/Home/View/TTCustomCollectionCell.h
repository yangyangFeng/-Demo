//
//  TTCustomCollectionCell.h
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTCustomCollectionCellDelegate <NSObject>

- (void)sendButtonClick:(NSIndexPath *)indexpath;

@end

@interface TTCustomCollectionCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIButton *city_button;
@property (nonatomic,strong) NSIndexPath *indexpath;
@property (nonatomic,weak) id<TTCustomCollectionCellDelegate> delegate;
@end
