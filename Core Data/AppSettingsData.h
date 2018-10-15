//
//  AppSettingsData.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-20.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AppSettingsData : NSObject
@property (nonatomic) CLLocationDirection heading;
@property (nonatomic) CLLocationCoordinate2D locationCoor2D;
@property (nonatomic) MKCoordinateSpan regionSpan;

+(instancetype) initWithlocationCoor2D: (CLLocationCoordinate2D*) locationCoor2D regionSpan: (MKCoordinateSpan*)regionSpan heading: (CLLocationDirection*)heading;
@end
