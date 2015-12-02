//
//  FirstViewController.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "FirstViewController.h"
#import "CitySelectView.h"
#import "JFAllCityNameViewController.h"
@interface FirstViewController ()
@property (nonatomic, strong) CitySelectView* cityView;
@end

@implementation FirstViewController
#pragma mark - ----------------------------Lazy loading----------------------------
- (CitySelectView*)cityView
{
    if (!_cityView) {
        _cityView = [[CitySelectView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, 235)];
    }
    return _cityView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavicationItem];
    // Do any additional setup after loading the view.
}

- (void)setNavicationItem
{
    NSLog(@"%@ \n item %@", self.navigationController, self.navigationItem);
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"商圈" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonDidClick:)];
    self.navigationItem.leftBarButtonItems = @[ leftItem ];
}

#pragma mark - ----------------------------Triggering method----------------------------
- (void)leftButtonDidClick:(id)sender
{


    if (self.cityView.alpha == 1.0) {
        [self.cityView hiden];
    }
    else {
        [self.view addSubview:self.cityView];
        [self.cityView show];
    }
     __weak typeof(self) weakself = self;
    [_cityView changeCity:^{
        [weakself.navigationController pushViewController:[JFAllCityNameViewController new] animated:YES];
    }];
}
#pragma mark - Navigation
@end
