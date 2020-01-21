//
//  AppDelegate.m
//  implicitTransition
//
//  Created by Gguomingyue on 2020/1/21.
//  Copyright © 2020 Gmingyue. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *viewController1 = [[UIViewController alloc] init];
    viewController1.view.backgroundColor = [UIColor redColor];
    viewController1.tabBarItem.title = @"vc1";
    UIViewController *viewController2 = [[UIViewController alloc] init];
    viewController2.view.backgroundColor = [UIColor greenColor];
    viewController2.tabBarItem.title = @"vc2";
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2];
    self.tabBarController.delegate = self;
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    [self.tabBarController.view.layer addAnimation:transition forKey:nil];
}

@end
