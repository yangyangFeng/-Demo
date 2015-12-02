
#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"

@interface AppDelegate ()
{
    NSArray * titles;
}
@property (nonatomic,strong) NSMutableArray *subviewControllers;
@end

@implementation AppDelegate
#pragma mark   ==============Lazy loading==============
-(NSMutableArray *)subviewControllers
{
    if (!_subviewControllers) {
        _subviewControllers = [NSMutableArray array];
        titles = @[@"首页",@"商圈",@"购物车",@"星评"];
    }
    return _subviewControllers;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [_window makeKeyAndVisible];
    
    [self addSubviewController:[FirstViewController new]];
    [self addSubviewController:[SecondViewController new]];
    [self addSubviewController:[ThreeViewController new]];
    [self addSubviewController:[FourViewController new]];
    
    UITabBarController * tabController = [[UITabBarController alloc]init];
    tabController.viewControllers = self.subviewControllers;

    _window.rootViewController = tabController;
    return YES;
}

- (void)addSubviewController:(UIViewController *)viewcontroller
{
    NSString * title =titles[self.subviewControllers.count];
    if (!self.subviewControllers.count) {
        title = titles[0];
    }
    viewcontroller.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[[UIImage imageNamed:title] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@选中",title]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    viewcontroller.title = title;
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:viewcontroller];
    [self.subviewControllers addObject:nav];
    //RGB(54, 185,175)
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:54/255.0 green:185/255.0 blue:175/255.0 alpha:1.0],UITextAttributeTextColor, nil] forState:UIControlStateSelected];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
