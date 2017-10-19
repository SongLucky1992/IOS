//
//  TabBarViewController.m
//  StudyTest
//
//  Created by haoyunsong on 2017/8/23.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tabBar setBackgroundColor:[UIColor redColor]];
//    NSLog(@"%@",self.tabBar.items);
    [self.tabBar setBarTintColor:[UIColor colorWithRed:36/255.0 green:36/255.0 blue:36/255.0 alpha:1]];
    [self.tabBar setUnselectedItemTintColor:[UIColor whiteColor]];
    [self.tabBar setTintColor:[UIColor colorWithRed:62/255.0 green:122/255.0 blue:167/255.0 alpha:1]];
    
    
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
