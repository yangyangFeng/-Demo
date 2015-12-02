//
//  CitySelectView.h
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySelectView : UIView
- (void)show;
- (void)hiden;
- (void)changeCity:(void(^)())block;
@end



@interface TTCityModel : NSObject
@property (nonatomic,assign) BOOL selected;
@end
