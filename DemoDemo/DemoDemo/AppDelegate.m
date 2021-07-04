//
//  AppDelegate.m
//  DemoDemo
//
//  Created by haijunyan on 2020/11/19.
//  Copyright © 2020 haijunyan. All rights reserved.
//

#import "AppDelegate.h"
//#import "ViewController.h"
#import "ResponderChainViewController.h"
#import "CatagoryViewController.h"
#import "OptimizationViewController.h"
#import "AutoReleaseViewController.h"
#import "SRCBAVPlayerViewController.h"
#import "NotificationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //Xcode11前生效
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    UIViewController *vC = [[AutoReleaseViewController alloc] init];
//    ((AutoReleaseViewController *)vC).SSS = ^(NSString *name) {//调用指令+全新(开启的)上下文环境"{}"
//        //全新上下文环境体系内执行上下文环境下的调用指令创建临时对象缓存后效果切换传送至当前屏上下文环境通过数模呈现至显示器，传送结束后销毁这些临时对象的缓存。
//
//    };

//    [((AutoReleaseViewController *)vC) testDescription];
    NotificationViewController *vC = [[NotificationViewController alloc] init];

    self.window.rootViewController = vC;
    //window核心化可见
    [self.window makeKeyAndVisible];
    return YES;
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}


//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
