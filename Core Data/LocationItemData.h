//
//  LocationItemData.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-20.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LocationItemData : NSObject
@property(nonatomic) NSDate* dateCreated;
@property(nonatomic) CLLocationDirection heading;
@property(nonatomic) CLLocationCoordinate2D locationCoor2D;
@property(nonatomic) int16_t speed;

+(instancetype) initToDefault;
+(instancetype) initWithHeading: (CLLocationDirection)heading locationCoor2D: (CLLocationCoordinate2D*) locationCoor2D speed: (int16_t)speed dateCreated: (NSDate*)dateCreated;
@end
