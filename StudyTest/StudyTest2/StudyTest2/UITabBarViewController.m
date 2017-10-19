//
//  UITabBarViewController.m
//  StudyTest2
//
//  Created by haoyunsong on 2017/8/29.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import "UITabBarViewController.h"
#import "ViewController.h"

@interface UITabBarViewController ()

@end

@implementation UITabBarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self.tabBar setBarTintColor:[UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1]];
        
        UINavigationController* nv1 = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
        UINavigationController* nv2 = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
        UINavigationController* nv3 = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
        UINavigationController* nv4 = [[UINavigationController alloc]initWithRootViewController:[[ViewController alloc]init]];
        self.viewControllers = @[nv1,nv2,nv3,nv4];
        
        UITabBarItem* item1 = [self.tabBar.items objectAtIndex:0];
        item1.title = @"首页";
        [item1 setImage:[UIImage imageNamed:@"index"]];
        [item1 setSelectedImage:[UIImage imageNamed:@"index-select"]];
        
        UITabBarItem* item2 = [self.tabBar.items objectAtIndex:1];
        item2.title = @"创投课程";
        [item2 setImage:[UIImage imageNamed:@"courses"]];
        [item2 setSelectedImage:[UIImage imageNamed:@"courses-select"]];
        
        UITabBarItem* item3 = [self.tabBar.items objectAtIndex:2];
        item3.title = @"路演直播";
        [item3 setImage:[UIImage imageNamed:@"roadshow"]];
        [item3 setSelectedImage:[UIImage imageNamed:@"roadshow-select"]];
        
        UITabBarItem* item4 = [self.tabBar.items objectAtIndex:3];
        item4.title = @"我的";
        [item4 setImage:[UIImage imageNamed:@"mine"]];
        [item4 setSelectedImage:[UIImage imageNamed:@"mine-select"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
