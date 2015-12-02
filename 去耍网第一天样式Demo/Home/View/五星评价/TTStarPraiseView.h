//
//  TTStarPraiseView.h
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTStarPraiseView : UIView
@property (nonatomic,copy) void(^selectStar_block)(NSInteger index);
@end
