//
//  CitySelectView.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "CitySelectView.h"
#import "TTCustomCollectionCell.h"

@interface CitySelectView () <UICollectionViewDataSource, UICollectionViewDelegate,TTCustomCollectionCellDelegate> {
    CGRect _frame;
    NSArray* _address;
    UILabel* cityLabel;
}
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* selectModels;
@property (nonatomic, strong) UIView* contentView;
@property (nonatomic, copy) void (^block)();
@end

@implementation CitySelectView
#pragma mark - ----------------------------Lazy loading----------------------------
- (UICollectionView*)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout* flowlayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height - 80) collectionViewLayout:flowlayout];

        _collectionView.backgroundColor = RGB(241, 241, 241);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        [_collectionView registerClass:[TTCustomCollectionCell class] forCellWithReuseIdentifier:@"TTCustomCollectionCell"];
        flowlayout.itemSize = CGSizeMake((WIDTH - 20 * 2 - 20) / 3, 44);
        flowlayout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
    }
    return _collectionView;
}

-(NSMutableArray *)selectModels
{
    if (!_selectModels) {
        _selectModels = [NSMutableArray array];
    }
    return _selectModels;
}
- (UIView*)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _contentView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _address = @[ @"全城", @"朝阳区", @"东城区", @"海淀区", @"西城区", @"丰台区", @"平谷区", @"延庆区", @"密云县", @"石景山区", @"门头沟", @"顺义区", @"怀柔区", @"房山区", @"昌平区", @"通州区", @"大兴区" ];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];

        self.contentView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height + 80);

        [self addSubview:self.contentView];
        [self.contentView addSubview:self.collectionView];

        UIView* toolView = [[UIView alloc] initWithFrame:CGRectMake(0, self.collectionView.height, self.contentView.width, self.contentView.height - frame.size.height)];
        //        RGB(241, 241, 241);
        cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.contentView.width - 20, 44)];
        cityLabel.centerY = toolView.height / 2;
        cityLabel.text = [NSString stringWithFormat:@"   当前城市: %@", @"北京"];
        cityLabel.textAlignment = NSTextAlignmentLeft;
        cityLabel.textColor = rgb(83, 83, 83);
        cityLabel.backgroundColor = [UIColor whiteColor];
        UILabel* changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cityLabel.width, 44)];
        changeLabel.textAlignment = NSTextAlignmentRight;
        changeLabel.backgroundColor = [UIColor blueColor];
        changeLabel.text = @"更换";
        changeLabel.textColor = rgb(25, 182, 158);

        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDidClick:)];
        [cityLabel addGestureRecognizer:tap];
        cityLabel.userInteractionEnabled = YES;
        [self.contentView addSubview:toolView];
        [toolView addSubview:cityLabel];

        self.alpha = 0;
        //        [cityLabel addSubview:changeLabel];
    }
    return self;
}

#pragma mark - ----------------------------Delegate methods----------------------------
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.selectModels.count != _address.count) {
        for (id temp in _address) {
            TTCityModel * model = [TTCityModel new];
            model.selected = NO;
            [self.selectModels addObject:model];
        }
    }
    return _address.count;
}
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* identifiter = @"TTCustomCollectionCell";

    TTCustomCollectionCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifiter forIndexPath:indexPath];
    cell.indexpath = indexPath;
    cell.delegate = self;
    [cell.city_button setTitle:_address[indexPath.row] forState:(UIControlStateNormal)];
    TTCityModel * model = self.selectModels[indexPath.row];
    cell.selected = model.selected;

    return cell;
}

- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{
    [collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    cityLabel.text = [NSString stringWithFormat:@"   当前城市: %@", _address[indexPath.row]];
    
    TTCityModel * model = self.selectModels[indexPath.row];
    for (TTCityModel * tempModel in self.selectModels) {
        tempModel.selected = NO;
    }
    model.selected = YES;
//    TTCustomCollectionCell * cell = (TTCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.cell_selected = model.selected;
    [collectionView reloadData];
    
}
#pragma mark - ----------------------------Public methods----------------------------
- (void)show
{
    [UIView animateWithDuration:0.55
                     animations:^{
                         self.alpha = 1.0;
                     }
                     completion:^(BOOL finished) {
                     }];
}

- (void)hiden
{
    [UIView animateWithDuration:0.15
        animations:^{
            self.alpha = 0;
        }
        completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
}

- (void)changeCity:(void (^)())block
{
    if (block) {
        _block = block;
    }
}
#pragma mark - ----------------------------Triggering method----------------------------
- (void)tapDidClick:(UITapGestureRecognizer*)tap
{
    [self hiden];
    if (_block) {
        _block();
    }
}
- (void)touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event
{
    [self hiden];
}

#pragma mark - ----------------------------Delegate methods----------------------------
-(void)sendButtonClick:(NSIndexPath *)indexpath
{
    [_collectionView selectItemAtIndexPath:indexpath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    cityLabel.text = [NSString stringWithFormat:@"   当前城市: %@", _address[indexpath.row]];
    
    TTCityModel * model = self.selectModels[indexpath.row];
    for (TTCityModel * tempModel in self.selectModels) {
        tempModel.selected = NO;
    }
    model.selected = YES;
    //    TTCustomCollectionCell * cell = (TTCustomCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.cell_selected = model.selected;
//    [_collectionView reloadData];
}
@end

@implementation TTCityModel



@end