//
//  TT_PCH.h
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#ifndef TT_PCH_h
#define TT_PCH_h
#import "BaseController.h"
#import "TTCategory.h"
//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//weak
#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark - degrees/radian functions
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#pragma mark - color functions
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBRED [UIColor colorWithRed:230/255.0f green:50/255.0f blue:61/255.0f alpha:1]
#define RGBYELLOW [UIColor colorWithRed:241/255.0f green:154/255.0f blue:48/255.0f alpha:1]


#define   WIDTH   [[UIScreen mainScreen] bounds].size.width
#define  HEIGHT  [[UIScreen mainScreen] bounds].size.height
#endif /* TT_PCH_h */
