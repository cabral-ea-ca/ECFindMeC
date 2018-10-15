//
//  AppSettingsData.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-20.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//


#import "AppSettingsData.h"

@implementation AppSettingsData
+ (instancetype)initWithlocationCoor2D:(CLLocationCoordinate2D *)locationCoor2D regionSpan:(MKCoordinateSpan *)regionSpan heading: (CLLocationDirection*)heading {
    AppSettingsData* thisClass = [ [ [ self class ] alloc ] init ];
    thisClass.locationCoor2D = *locationCoor2D;
    thisClass.regionSpan     = *regionSpan;
    thisClass.heading        = *heading;
    
    return thisClass;
}
@end
