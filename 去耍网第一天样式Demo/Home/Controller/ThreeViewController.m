//
//  ThreeViewController.m
//  去耍网第一天样式Demo
//
//  Created by 邴天宇 on 15/12/1.
//  Copyright © 2015年 邴天宇. All rights reserved.
//

#import "ThreeViewController.h"
#import "TTCustomCell.h"
@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIBezierPath *path;
@end

@implementation ThreeViewController
{
    CALayer     *_layer;
    UIButton    *_shopCartbtn;
    CAShapeLayer *_shaperLayer;
    UILabel     *_cntLabel;
    NSInteger    _cnt;
    UIButton    *_btn;
    NSMutableArray *_dataSource;
}

-(UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
        
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}

#pragma mark - ----------------------------Delegate methods----------------------------

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifiter = @"customtableviewcell11";
    TTCustomCell * cell = [tableView dequeueReusableCellWithIdentifier:identifiter];
    if (!cell) {
        cell = [[TTCustomCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifiter];
    }
    cell.logo.image = [UIImage imageNamed:@"logo.jpg"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TTCustomCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView = cell.logo;
    CGRect rect = [tableView rectForRowAtIndexPath:indexPath];
    rect.origin.y = rect.origin.y - [self.tableview contentOffset].y;
    
    CGRect headRect = imageView.frame;
    headRect.origin.y = rect.origin.y+headRect.origin.y;
    [self startAnimationWithRect:headRect ImageView:imageView];

}
#pragma mark - ----------------------------Private methods----------------------------
-(void)startAnimationWithRect:(CGRect)rect ImageView:(UIImageView *)imageView
{
    if (!_layer) {
        //        _btn.enabled = NO;
        _layer = [CALayer layer];
        _layer.contents = (id)imageView.layer.contents;
        
        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.bounds = rect;
        [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
        _layer.masksToBounds = YES;
        // 导航64
        _layer.position = CGPointMake(imageView.center.x, CGRectGetMidY(rect));
        NSLog(@"%@ y-",NSStringFromCGPoint(_layer.position));
        //        [_tableView.layer addSublayer:_layer];
        [self.view.layer addSublayer:_layer];
        self.path = [UIBezierPath bezierPath];
        [_path moveToPoint:_layer.position];
        //        (SCREEN_WIDTH - 60), 0, 50, 50)
        [_path addQuadCurveToPoint:CGPointMake(WIDTH - WIDTH /2+ 44, HEIGHT-40) controlPoint:CGPointMake(WIDTH/2,rect.origin.y-80)];
        //        [_path addLineToPoint:CGPointMake(SCREEN_WIDTH-40, 30)];
    }
    [self groupAnimation];
}
-(void)groupAnimation
{
    _tableview.userInteractionEnabled = NO;
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.25f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:2.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.25;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:2.0f];
    narrowAnimation.duration = 0.15f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:0.3f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = .4f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    static NSString * i = @"0";
    if (anim == [_layer animationForKey:@"group"]) {
        _tableview.userInteractionEnabled = YES;
        //        _btn.enabled = YES;
        [_layer removeFromSuperlayer];
        _layer = nil;
        _cnt++;
        if (_cnt) {
            _cntLabel.hidden = NO;
        }
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
//        _cntLabel.text = [NSString stringWithFormat:@"%d",_cnt];
        [_cntLabel.layer addAnimation:animation forKey:nil];
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        

        UITabBarItem * item=[self.tabBarController.tabBar.items objectAtIndex:2];
        int numbers = [i intValue];
        NSLog(@"%d",numbers);
        item.badgeValue = [NSString stringWithFormat:@"%d",++numbers];
        i = [NSString stringWithFormat:@"%d",numbers];
//        [item.layer addAnimation:shakeAnimation forKey:nil];
    }
}

@end
