//
//  AppDelegate.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-14.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Alerts/DisplayAlert.h"
#import "DataBase.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) DataBase* database;
@property (strong, nonatomic) DisplayAlert *displayAlert;
@property (nonatomic) MKCoordinateSpan inheritedSpan;
@property (nonatomic) CLLocationCoordinate2D defaultLocation;
@property (nonatomic) MKCoordinateSpan defaultRegionSpan;
@property (nonatomic) CLLocationDirection defaultHeading;
@end

