//
//  UIViewController+GSNavigation.m
//  StudyTest
//
//  Created by haoyunsong on 2017/8/31.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import "UIViewController+GSNavigation.h"
#import "SearchViewController.h"
#import <objc/runtime.h>
static const void*GSSearchFieldKey = @"GSSearchFieldKey";

@implementation UIViewController (GSNavigation)

- (void)setSearchField:(UITextField *)searchFields {
    objc_setAssociatedObject(self,GSSearchFieldKey,searchFields,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITextField*)searchField {
    return objc_getAssociatedObject(self, GSSearchFieldKey);
}

- (void)setFirstNavigation {
    //    [self.navigationController.navigationBar setBackgroundColor:[UIColor redColor]];
    //    [self.navigationController.view setBackgroundColor:[UIColor blueColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 64, 24)];
    imageView.image = [UIImage imageNamed:@"logo"];
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:imageView];
    //    self.navigationItem.leftBarButtonItem.width = -15;
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc]initWithCustomView:imageView];
    UIBarButtonItem* spaceButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton.width = 15;
    self.navigationItem.leftBarButtonItems = @[leftButton,spaceButton];
    
    UITextField* textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 11, 229, 24)];//30+64
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = UIColorFromHex(0x696969, 1).CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 3;
    self.searchField = textField;
    self.navigationItem.titleView = textField;
    
    UIButton* searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 15, 20, 20)];//30+64+229+15
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
}

- (void)searchAction {
    [self.searchField resignFirstResponder];
    if ([self.searchField.text isEqualToString:@""]) {
        return;
    }
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.searchField resignFirstResponder];
}

@end
