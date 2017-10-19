//
//  SecondViewController.m
//  StudyTest
//
//  Created by haoyunsong on 2017/8/22.
//  Copyright © 2017年 XingHeQiFu. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+GSNavigation.h"
#import "FirstViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SecondViewController () <CLLocationManagerDelegate,MKMapViewDelegate>{
    MKMapView* _mapView;
    CLLocationManager* _locationManager;
}

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setFirstNavigation];
    
//    UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 20, 20)];
//    [btn setTitle:@"123" forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [self.view addSubview:btn];
//    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
//    UIDatePicker*picker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 120)];
//    picker.datePickerMode = UIDatePickerModeDate;
//    picker.minimumDate = [NSDate date];
//    picker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh-cn"];
//
////    picker.locale
//    [self.view addSubview:picker];
    
    
    [self createMap];
    
    [self selfLocation];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createMap {
    _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate=self;
    [self.view addSubview:_mapView];
    UILongPressGestureRecognizer* longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpreshAction:)];
    [_mapView addGestureRecognizer:longPress];
    
    NSArray *mapTypeArray =@[@"标准",@"卫星",@"混合"];
    
    UISegmentedControl *segment =[[UISegmentedControl alloc] initWithItems:mapTypeArray];
    
    segment.frame=CGRectMake(50,50,300,50);
    
    [_mapView addSubview:segment];
    
    segment.selectedSegmentIndex=0;
    
    //添加UISegmentedControl的事件响应方法
    
    [segment addTarget:self action:@selector(mapTypeChanged:) forControlEvents:UIControlEventValueChanged];
    
    
}

- (void)longpreshAction:(UILongPressGestureRecognizer*)sender {
    if(sender.state!=UIGestureRecognizerStateBegan) {
        
        return;
        
    }
    
    //获取手势在uiview上的位置
    
    CGPoint longPressPoint = [sender locationInView:_mapView];
    
    //将手势在uiview上的位置转化为经纬度
    
    CLLocationCoordinate2D coordinate2d =[_mapView convertPoint:longPressPoint toCoordinateFromView:_mapView];
    
    NSLog(@"%f%f",coordinate2d.longitude,coordinate2d.latitude);
    
    //添加大头针
    
    MKPointAnnotation *pointAnnotation =[[MKPointAnnotation alloc] init];
    
    //设置经纬度
    
    pointAnnotation.coordinate=coordinate2d;
    
    //设置主标题和副标题
    
    pointAnnotation.title=@"我在这里";
    
    pointAnnotation.subtitle=@"你好，世界！";
    
    //添加到地图上
    
    [_mapView addAnnotation:pointAnnotation];
    
    MKCircle *circle =[MKCircle circleWithCenterCoordinate:coordinate2d radius:50];
    
    //先添加，在回调方法中创建覆盖物
    
    [_mapView addOverlay:circle];
}

- (void)mapTypeChanged:(UISegmentedControl*)sender {
    //获得当前segment索引
    
    NSInteger index =sender.selectedSegmentIndex;
    
    //设置地图的显示方式
    
    _mapView.mapType =index;
}

- (void)selfLocation {
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    _locationManager.distanceFilter = 10.0;
    
    _locationManager.delegate = self;
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (status == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestAlwaysAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation* location = [locations firstObject];
    
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.01, 0.01));
    [_mapView setRegion:region animated:YES];
    
    MKPointAnnotation* point = [[MKPointAnnotation alloc]init];
    point.coordinate = location.coordinate;
    point.title = @"I'm here!";
    point.subtitle = @"hello";
    [_mapView addAnnotation:point];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation{
    
    //复用
    
    MKPinAnnotationView *annotationView =(MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN"];
    
    //判断复用池中是否有可用的
    
    if(annotationView==nil) {
        
        annotationView =(MKPinAnnotationView *)[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN"];
        
    }
    
    //添加左边的视图
    
    UIImageView *imageView =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    
    imageView.frame=CGRectMake(0,0,50,50);
    
    annotationView.leftCalloutAccessoryView=imageView;
    
    //显示
    
    annotationView.canShowCallout=YES;
    
    //设置是否显示动画
    
    annotationView.animatesDrop=YES;
    
    //设置右边视图
    
    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0,0,30,30)];
    
    label.text=@">>";
    
    annotationView.rightCalloutAccessoryView=label;
    
    //设置大头针的颜色
    
    annotationView.pinColor=MKPinAnnotationColorPurple;
    
    return annotationView;
}

//覆盖物的回调方法

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id)overlay{
    
    //创建圆形覆盖物
    
    MKCircleRenderer *circleRender =[[MKCircleRenderer alloc] initWithCircle:overlay];
    
    //设置填充色
    
    circleRender.fillColor=[UIColor purpleColor];
    
    //设置边缘颜色
    
    circleRender.strokeColor=[UIColor redColor];
    
    return circleRender;
    
}

//解决手势冲突，可以同时使用多个手势

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

{
    
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnAction {
    [self.navigationController pushViewController:[FirstViewController new] animated:YES];
}


@end
