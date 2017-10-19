//
//  UIViewController+GSNavigation.h
//  StudyTest
//
//  Created by haoyunsong on 2017/8/31.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (GSNavigation)
@property (nonatomic, strong) UITextField*searchField;
- (void)setFirstNavigation;
- (void)searchAction;
@end
