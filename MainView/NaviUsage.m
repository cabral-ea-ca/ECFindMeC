//
//  NaviUsage.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-16.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "NaviUsage.h"

@interface CNaviUsage()
- (void) naviUsageForFast: (CustCLLocationManager*) locationManager;
- (void) naviUsageForSFast: (CustCLLocationManager*) locationManager;
- (void) naviUsageForWalking: (CustCLLocationManager*) locationManager;
- (void) naviUsageNone: (CustCLLocationManager*) locationManager;
@end

@implementation CNaviUsage
- (instancetype)init
{
    self = [super init];
    if (self) {
        _naviUsageType = kNoNavi;
        typeStringTable = [ NSArray arrayWithObjects: @"None", @"Walking Navi", @"Fast Navi", @"Super Fast Navi" , nil];
    }
    return self;
}

- (NSString *)naviUsageDesc{
    return [ typeStringTable objectAtIndex:_naviUsageType ];
}

- (void)naviUsageForFast: (CustCLLocationManager *)locationManager{
    printf( "CNaviUsage: naviUsageForFast called\n" );
    [ locationManager stopUpdatingLocation ];
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.activityType = CLActivityTypeAutomotiveNavigation;
    locationManager.headingFilter = 5.0;
    locationManager.distanceFilter = 60.0;
    locationManager.lastTimeStamp  = nil;
    locationManager.updateInterVal = 30;
    [ locationManager startUpdatingLocation ];
}

- (void)naviUsageForSFast: (CustCLLocationManager *)locationManager{
    printf( "CNaviUsage: naviUsageForSFast called\n" );
    [ locationManager stopUpdatingLocation ];
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    locationManager.activityType = CLActivityTypeOther;
    locationManager.headingFilter = 5.0;
    locationManager.distanceFilter = 120.0;
    locationManager.lastTimeStamp  = nil;
    locationManager.updateInterVal = 30;
    [ locationManager startUpdatingLocation ];
}

- (void)naviUsageForWalking: (CustCLLocationManager *)locationManager{
    printf( "CNaviUsage: naviUsageForWalking called\n" );
    [ locationManager stopUpdatingLocation ];
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    locationManager.activityType = CLActivityTypeFitness;
    locationManager.headingFilter = 1;
    locationManager.distanceFilter = 10.0;
    locationManager.lastTimeStamp  = nil;
    locationManager.updateInterVal = 15;
    [ locationManager startUpdatingLocation ];
}

- (void)naviUsageNone: (CustCLLocationManager *)locationManager{
    printf( "CNaviUsage: naviUsageNone called\n" );
    [ locationManager stopUpdatingLocation ];
    locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    locationManager.activityType = CLActivityTypeOther;
    locationManager.headingFilter = 90;
    locationManager.distanceFilter = 3000;
    locationManager.lastTimeStamp  = nil;
    locationManager.updateInterVal = -1;
}

- (void)startNavi:(CustCLLocationManager *)locationManager{
    printf( "CNaviUsage: startNavi called\n" );
    switch( _naviUsageType ) {
        case kUnknownNavi:          printf( "What happened???\n" );
        case kNoNavi:           [ self naviUsageNone: locationManager ]; break;
        case kUseForWalking:    [ self naviUsageForWalking: locationManager ]; break;
        case kFastNavigation:   [ self naviUsageForFast: locationManager ]; break;
        case kSFastNavigation:  [ self naviUsageForSFast: locationManager ]; break;
    }
}

- (void)switchNavi:(CustCLLocationManager *)locationManager{
    printf( "CNaviUsage: switchNavi called\n" );
    enum NaviUsageType oldType = _naviUsageType;
    switch( _naviUsageType ) {
        case kUnknownNavi:      printf( "What happened???\n" );
        case kNoNavi:           _naviUsageType = kUseForWalking; break;
        case kUseForWalking:    _naviUsageType = kFastNavigation; break;
        case kFastNavigation:   _naviUsageType = kSFastNavigation; break;
        case kSFastNavigation:  _naviUsageType = kNoNavi; break;
    }
    printf( "naviUsageNone called %d -> %d\n", oldType, _naviUsageType );
    [ self startNavi: locationManager ];
}
@end
