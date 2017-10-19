//
//  BannerModel.h
//  StudyTest
//
//  Created by haoyunsong on 2017/9/6.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ABannerModel;
@interface BannerModel : NSObject
@property (nonatomic, strong) NSString* status_txt;
@property (nonatomic, assign) NSInteger status_code;
@property (nonatomic, strong) NSMutableArray<ABannerModel *>*aBannerList;
@end

@interface ABannerModel :NSObject
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* course_id;

@end
