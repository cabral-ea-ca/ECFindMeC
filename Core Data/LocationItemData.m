//
//  LocationItemData.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-20.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "../AppDelegate.h"
#import "LocationItemData.h"

@implementation LocationItemData
+ (instancetype)initToDefault{
    LocationItemData* thisClass = [ [ [ self class ] alloc ] init ];
    thisClass.heading        = 0.0;
    thisClass.locationCoor2D = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultLocation;;
    thisClass.speed          = 0;
    return thisClass;
}

+ (instancetype)initWithHeading: (CLLocationDirection)heading locationCoor2D:(CLLocationCoordinate2D *)locationCoor2D speed:(int16_t)speed dateCreated: (NSDate*)dateCreated;{
    LocationItemData* thisClass = [ [ [ self class ] alloc ] init ];
    thisClass.heading        = heading;
    thisClass.locationCoor2D = *locationCoor2D;
    thisClass.speed          = speed;
    thisClass.dateCreated    = dateCreated;
    
    return thisClass;
}
@end
