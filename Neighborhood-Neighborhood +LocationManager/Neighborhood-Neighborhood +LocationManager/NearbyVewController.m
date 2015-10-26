//
//  NearbyVewController.m
//  Neighborhood-Neighborhood +LocationManager
//
//  Created by Jane on 10/23/15.
//  Copyright © 2015 Jane. All rights reserved.
//

#import "NearbyVewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface NearbyVewController ()<AMapNearbySearchManagerDelegate>
{
    AMapNearbySearchManager *_nearbyManager;
}

@end

@implementation NearbyVewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nearbyManager = [AMapNearbySearchManager sharedInstance];
    _nearbyManager.delegate = self;
    if (_nearbyManager.isAutoUploading)
    {
        [_nearbyManager stopAutoUploadNearbyInfo];//关闭自动上传
    }
    else
    {
        [_nearbyManager startAutoUploadNearbyInfo];//开启自动上传
    }
    // Do any additional setup after loading the view.
}

- (AMapNearbyUploadInfo *)nearbyInfoForUploading:(AMapNearbySearchManager *)manager
{
    AMapNearbyUploadInfo *info = [[AMapNearbyUploadInfo alloc] init];
    info.userID = @"1";
    info.coordinate = CLLocationCoordinate2DMake(39.004, 114.003);
    
    return info;
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
