//
//  BannerModel.m
//  StudyTest
//
//  Created by haoyunsong on 2017/9/6.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel

- (BOOL) modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (self.aBannerList == nil) {
        self.aBannerList = [[NSMutableArray alloc]init];
    }
    
    for (NSDictionary* d in [dic objectForKey:@"data"]) {
        ABannerModel* model = [ABannerModel yy_modelWithDictionary:d];
        [self.aBannerList addObject:model];
    }
    
    return YES;
}

@end

@implementation ABannerModel

+ (NSArray*) modelPropertyWhitelist {
    
    return @[@"image",@"course_id"];
}

- (BOOL) modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.image = [self.image stringByReplacingOccurrencesOfString:@"../" withString:server];
    
    return YES;
}

@end
