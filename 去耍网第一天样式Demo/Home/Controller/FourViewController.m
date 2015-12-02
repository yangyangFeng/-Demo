//
//  FourViewController.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "FourViewController.h"


#import "TTStarPraiseView.h"

@interface FourViewController ()

@property (nonatomic,strong) TTStarPraiseView *starView;
@property (nonatomic,strong) UILabel * label;
@end

@implementation FourViewController
-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 100)];
        [_label setFont:[UIFont systemFontOfSize:24]];
        _label.text = @"当前未评价";
    }
    return _label;
}
-(TTStarPraiseView *)starView
{
    if (!_starView) {
        _starView = [[TTStarPraiseView alloc]initWithFrame:CGRectMake(150, 400, WIDTH - 150, 54)];
    }
    return _starView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSubviews];
    // Do any additional setup after loading the view.
}

- (void)setSubviews
{
    [self.view addSubview:self.label];
    [self.view addSubview:self.starView];
    __weak typeof(self) weakSelf=self;
    [self.starView setSelectStar_block:^(NSInteger index) {
        NSLog(@"%ld",index);
        weakSelf.label.text = [NSString stringWithFormat:@"您已做出%ld星好评",index];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
