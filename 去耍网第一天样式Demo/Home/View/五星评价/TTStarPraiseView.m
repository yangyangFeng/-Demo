//
//  TTStarPraiseView.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "TTStarPraiseView.h"



#define STAR_IMAGEVIEW_TAG 999

@interface TTStarPraiseView ()
@property (nonatomic, strong) NSMutableArray* starsArray;
@end
@implementation TTStarPraiseView
{
    void(^my_selectStar_block)(NSInteger index);
}
#pragma mark - ----------------------------Lazy loading----------------------------
- (NSMutableArray*)starsArray
{
    if (!_starsArray) {
        _starsArray = [NSMutableArray array];
    }
    return _starsArray;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i < 5; i++) {
            UIImageView* imageview = [[UIImageView alloc] initWithFrame:CGRectMake(5 + ((frame.size.width - 6 * 5) / 5 + 5) * i, 5, (frame.size.width - 6 * 5) / 5, frame.size.height - 10)];
            imageview.userInteractionEnabled = YES;
            UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick:)];
            [imageview addGestureRecognizer:tap];

            imageview.tag = STAR_IMAGEVIEW_TAG + i;

            [self changeStartState:NO withImageView:imageview];
            [self addSubview:imageview];
            [self.starsArray addObject:imageview];
        }
    }
    return self;
}

- (void)setSelectStar_block:(void (^)(NSInteger index))selectStar_block
{
    if (selectStar_block) {
        my_selectStar_block = selectStar_block;
    }
}
#pragma mark - ----------------------------Private methods----------------------------
- (void)changeStartState:(BOOL)light withImageView:(UIImageView*)imageview
{
    [UIView animateWithDuration:0.15
                     animations:^{
                         if (light) {
                             imageview.image = [UIImage imageNamed:@"星评选中"];
                         }
                         else {
                             imageview.image = [UIImage imageNamed:@"星评"];
                         }
                     }];    
}

- (void)selectIndex:(NSInteger)index
{
    for (int i = 0; i < 5; i++) {
        if (i <= index) {
            [self changeStartState:YES withImageView:self.starsArray[i]];
        }
        else {
            [self changeStartState:NO withImageView:self.starsArray[i]];
        }
    }
}
#pragma mark - ----------------------------Triggering method----------------------------
- (void)didClick:(UITapGestureRecognizer*)tap
{
    UIImageView* view = (UIImageView*)tap.view;
    NSInteger index = view.tag - STAR_IMAGEVIEW_TAG;
    [self selectIndex:index];
    if (my_selectStar_block) {
            my_selectStar_block(++index);
    }
}
@end
