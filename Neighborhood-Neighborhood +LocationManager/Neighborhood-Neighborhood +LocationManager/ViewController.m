//
//  ViewController.m
//  Neighborhood-Neighborhood +LocationManager
//
//  Created by Jane on 10/23/15.
//  Copyright © 2015 Jane. All rights reserved.
//

#import "ViewController.h"
#import <INTULocationManager/INTULocationManager.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#define SEARCH_GOOGLE @"http://api.map.baidu.com/geocoder/v2/?ak=E4805d16520de693a3fe707cdc962045&callback=renderReverse&location=%f,%f&output=json&pois=1"

@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate>
{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, self.view.frame.size.width, 50)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    [MAMapServices sharedServices].apiKey = @"98e8743fceb766fbedbd58f61e25d93d";
    [AMapSearchServices sharedServices].apiKey = @"98e8743fceb766fbedbd58f61e25d93d";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    
    [self.view addSubview:_mapView];
    //初始化检索对象
    //初始化检索对象
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    regeo.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    
    //regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    regeo.radius = 10000;
    regeo.requireExtension = YES;
    //regeoRequest.requireExtension = YES;
    //发起逆地理编码
    [_search AMapReGoecodeSearch: regeo];
    
}


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        //构造AMapNearbySearchRequest对象，配置周边搜索参数
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];

        //regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        regeo.radius = 10000;
        regeo.requireExtension = YES;
        //regeoRequest.requireExtension = YES;
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeo];
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.addressComponent.province];
        NSLog(@"ReGeo: %@", result);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
