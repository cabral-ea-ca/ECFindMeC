//
//  AppSettings+CoreDataProperties.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

#import "../AppDelegate.h"
#import "AppSettings+CoreDataProperties.h"

@implementation AppSettings (CoreDataProperties)

@dynamic lastHeading;
@dynamic lastLatitude;
@dynamic lastLatitudeDelta;
@dynamic lastLongitude;
@dynamic lastLongitudeDelta;
@dynamic lastUpdate;

+ (NSFetchRequest<AppSettings *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"AppSettings"];
}

+(void)getRecord: (NSManagedObjectContext *)moc rtnValue: (BOOL *)rtnValue appSettings: (AppSettings **)appSettings appSettingsData: (AppSettingsData **)appSettingsData{
    *rtnValue = FALSE;
    *appSettings = nil;
    *appSettingsData = nil;
    
    NSFetchRequest<AppSettings *> *appSettingsFetchReq = [ self fetchRequest ];
    //appSettingsFetchReq.entity = entity;
    
    NSError* error = nil;
    NSArray* records = [ moc executeFetchRequest:appSettingsFetchReq error:&error ] ;
    if( error == nil ){
        if( records != nil && records.count == 1 ){
            *appSettings = [ records objectAtIndex:0 ];
            CLLocationCoordinate2D locationCoor2D = CLLocationCoordinate2DMake((*appSettings).lastLatitude, (*appSettings).lastLongitude);
            MKCoordinateSpan regionSpan = MKCoordinateSpanMake((*appSettings).lastLatitudeDelta, (*appSettings).lastLongitudeDelta);
            CLLocationDirection heading = (*appSettings).lastHeading;
            *appSettingsData = [ AppSettingsData initWithlocationCoor2D: &locationCoor2D regionSpan: &regionSpan heading: &heading ];
            *rtnValue = TRUE;
            printf( "AppSettings:getRecord called OK\n" );
        }
        else{
            CLLocationCoordinate2D locationCoor2D = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultLocation;
            MKCoordinateSpan regionSpan = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultRegionSpan;
            CLLocationDirection heading = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultHeading;
            *appSettingsData = [ AppSettingsData initWithlocationCoor2D: &locationCoor2D regionSpan: &regionSpan heading: &heading];
            printf( "AppSettings:getRecord Cannot get records\n" );
        }
    }
    else{
        CLLocationCoordinate2D locationCoor2D = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultLocation;
        MKCoordinateSpan regionSpan = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultRegionSpan;
        CLLocationDirection heading = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultHeading;
        *appSettingsData = [ AppSettingsData initWithlocationCoor2D: &locationCoor2D regionSpan: &regionSpan heading: &heading ];
        NSLog(@"AppSettings:getRecord Error=<%@> Reason=<%@>", [ error localizedDescription ], [ error localizedFailureReason ]);
    }
}

- (void)saveRecord:(AppSettingsData *)appSettingsData moc:(NSManagedObjectContext *)moc{
    [ self setLastUpdate:[NSDate date] ];
    [ self setLastLatitude:  appSettingsData.locationCoor2D.latitude ];
    [ self setLastLongitude: appSettingsData.locationCoor2D.longitude ];
    [ self setLastLatitudeDelta: appSettingsData.regionSpan.latitudeDelta ];
    [ self setLastLongitudeDelta: appSettingsData.regionSpan.longitudeDelta ];
    [ self setLastHeading: appSettingsData.heading ];
    
    NSError* error = nil;
    [ moc save: &error ];
    if( error == nil ){
        printf( "AppSettings:saveRecord called OK\n" );
    }
    else{
        NSLog(@"AppSettings:saveRecord Error=<%@> Reason=<%@>", [ error localizedDescription ], [ error localizedFailureReason ]);
    }
}
@end
