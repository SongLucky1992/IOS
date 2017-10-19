//
//  FirstViewController.m
//  StudyTest
//
//  Created by haoyunsong on 2017/8/22.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import "FirstViewController.h"
#import "BannerModel.h"
#import "SDCycleScrollView.h"

@interface FirstViewController ()<UITextFieldDelegate,SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SDCycleScrollView * cycleView;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSString * abc;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
//    __weak NSString* str = @"123";
//    str = @"145";
//    NSLog(@"%@",str);
    
//    [self setFirstNavigation];
    self.searchField.delegate = self;
    [self setValue:@"123" forKey:@"abc"];
    
    DLog(@"%@",_abc);
    
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.cycleView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addObserver:self forKeyPath:@"abc" options:NSKeyValueObservingOptionNew context:nil];
    [self getBanner];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self removeObserver:self forKeyPath:@"abc"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    DLog(@"%@",keyPath);
    DLog(@"%@",object);
    DLog(@"%@",change);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载  

- (UITableView*)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (SDCycleScrollView*)cycleView {
    if (_cycleView == nil) {
        _cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, WIDTH, 193) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        _cycleView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleView.pageDotColor = [UIColor whiteColor];
        _cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
        _cycleView.pageControlDotSize = CGSizeMake(8, 8);
        _cycleView.delegate = self;
    }
    return _cycleView;
}

#pragma mark - createUI
- (void)getBanner {
    
    NSDictionary* dic = @{@"flag":@"banner"};
    sWeakSelf(self);
    [[AFAppDotNetAPIClient sharedClient] POST:@"IndexBannerCourse.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        BannerModel* model = [BannerModel yy_modelWithDictionary:responseObject];
        
        if (model.status_code == 9000) {
            NSMutableArray* array = [NSMutableArray new];
            NSInteger i = 0;
            for (ABannerModel*m in model.aBannerList) {
                if (i == 0) {
                    m.image = @"http://v.rongkuai.com/courseImage/Bill.jpg";
                } else if (i == 2) {
                    m.image = @"http://v.rongkuai.com/courseImage/rongkuai.jpg";
                }
                i++;
                [array addObject:m.image];
            }
            weakself.cycleView.imageURLStringsGroup = array;
        }
        [self setValue:@"234" forKey:@"abc"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@",error);
    }];
}

#pragma mark - btnAction

- (void)btnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    DLog(@"%ld",(long)index);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    if ([textField isEqual:self.searchField]) {
        [self searchAction];
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"haha");
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row%3==2) {
        return 80+10;
    }
    return 80+25;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 193;
    }
    return 32;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 52;
    }
    return 0.1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"myCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    for (UIView* view in [cell contentView].subviews) {
//        [view removeFromSuperview];
//    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.cycleView;
    } else {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 32)];
        return view;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 52)];
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)dealloc
{
    
}


@end
