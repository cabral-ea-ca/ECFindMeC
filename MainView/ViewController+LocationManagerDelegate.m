//
//  ViewController+LocationManagerDelegate.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-18.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "ViewController+LocationManagerDelegate.h"
#import "../AppDelegate.h"
#import "../Core Data/LocationItemData.h"

@implementation ViewController (LocationManagerDelegate)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation* lastLocationData = [ locations lastObject ];
    printf( "locationManager: didUpdateLocations called\n" );
    
    // compute
    short speed = lastLocationData.speed <= 0.0 ? 0 : (short)((lastLocationData.speed*3.6)+0.5);
    NSString* posStr =  [ NSString stringWithFormat:@"%0.5lf : %0.5lf, %d km/h", lastLocationData.coordinate.latitude, lastLocationData.coordinate.longitude, speed];
    [ self.locationLabel setText:posStr ];
    // posStr = nil;
    
    MKMapCamera* newCamera = [ self.mapView.camera copy ] ;
    newCamera.heading      = lastLocationData.course;
    [ self.mapView setCamera:newCamera animated: FALSE ];
    [ self.mapView setCenterCoordinate:lastLocationData.coordinate animated:TRUE ];
    // newCamera = nil;
    
    // compare current time with update interval
    NSDate* currentDate = lastLocationData.timestamp ;
    BOOL updateNow = FALSE;
    CustCLLocationManager* custManager =  (CustCLLocationManager*) manager;
    if( custManager.lastTimeStamp == nil ){
        custManager.lastTimeStamp = currentDate;
        updateNow = TRUE;
    }
    else if( custManager.updateInterVal > 0 && (int)([currentDate timeIntervalSinceDate:custManager.lastTimeStamp ]) > custManager.updateInterVal ){
        // custManager.lastTimeStamp = nil;
        custManager.lastTimeStamp = currentDate;
        updateNow = TRUE;
    }
    // currentDate = nil;
    
    if( updateNow ){
        CLLocationCoordinate2D locationCoor2D = lastLocationData.coordinate;
        LocationItemData* locationItemData    = [ LocationItemData initWithHeading: lastLocationData.course locationCoor2D: &locationCoor2D speed: lastLocationData.speed dateCreated: lastLocationData.timestamp ];
        [ ((AppDelegate*)(UIApplication.sharedApplication.delegate)).database addLocationItem: locationItemData ];
    }
    // lastLocationData = nil;
}
@end
