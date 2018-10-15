//
//  ViewController.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-14.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIColor.h>
#import "../AppDelegate.h"
#import "ViewController+CheckRoutines.h"
#import "../Core Data/AppSettings+CoreDataClass.h"

@interface ViewController()
- (void) applicationDidBecomeActive:(UIApplication *)application;
- (void) applicationWillTerminate:(UIApplication *)application;
@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        locationManager = [ [CustCLLocationManager alloc] init ];
        lockOrientation = [ [ CLockUsage alloc ] init ];
        naviUsage       = [ [ CNaviUsage alloc ] init ];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        locationManager = [ [CustCLLocationManager alloc] init ];
        lockOrientation = [ [ CLockUsage alloc ] init ];
        naviUsage       = [ [ CNaviUsage alloc ] init ];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [ _btnNaviUsage setTitle: naviUsage.naviUsageDesc ];
    [ _btnLockOrientation setTitle: lockOrientation.lockUsageDesc ];
    [ _authorizationLabel setText: @"" ];
    [ _headingOrientation setText: @"" ];
    [ _locationLabel setText: @"" ];

    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.distanceFilter = 10.0;
    locationManager.headingFilter = 1.0;
    
    [ NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil ];
    [ NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil ];

    AppSettingsData* appSettingsData = nil;
    [((AppDelegate*)(UIApplication.sharedApplication.delegate)).database getAppSettings: &appSettingsData ];
    CLLocationCoordinate2D currLocation = appSettingsData.locationCoor2D ;
    MKCoordinateSpan span               = appSettingsData.regionSpan;
    MKCoordinateRegion region           = MKCoordinateRegionMake(currLocation, span);
    [ _mapView setRegion:region animated: FALSE ];
    MKMapCamera* newCamera = [ self.mapView.camera copy ] ;
    newCamera.heading      = appSettingsData.heading;
    [ self.mapView setCamera:newCamera animated: FALSE ];
    [ _mapView setCenterCoordinate:currLocation animated:TRUE ];
}

- (void)viewDidAppear:(BOOL)animated{
    [ super viewDidAppear: animated];
    [ self checkLocationServ ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    return( lockOrientation.lockUsageType == kUnlocked ? TRUE : FALSE ) ;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    printf( "ViewController: applicationDidBecomeActive called\n" );
    [ self checkLocationServ ];
}

- (void)applicationWillTerminate:(UIApplication *)application{
    printf ( "ViewController: applicationWillTerminate called\n" );
    CLLocationCoordinate2D locationCoor2D = _mapView.centerCoordinate;
    MKCoordinateSpan regionSpan = _mapView.region.span;
    CLLocationDirection heading = _mapView.camera.heading;
    AppSettingsData* appSettingsData = [ AppSettingsData initWithlocationCoor2D: &locationCoor2D regionSpan: &regionSpan heading: &heading ];
    [((AppDelegate*)(UIApplication.sharedApplication.delegate)).database saveAppSettings: appSettingsData ];
}

- (void) initNavi{
    printf( "ViewController: initNavi called\n" );
    if( naviUsage.naviUsageType == kNoNavi ){
        [ _mapView setShowsUserLocation:FALSE ];
        [ _locationLabel setText: @"" ];
    }
    else{
        [ _mapView setShowsUserLocation:TRUE ];
        [ _locationLabel setText: @"Querying" ];
    }
}
@end
