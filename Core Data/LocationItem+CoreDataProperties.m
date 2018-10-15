//
//  LocationItem+CoreDataProperties.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

#import "LocationItem+CoreDataProperties.h"

@implementation LocationItem (CoreDataProperties)
@dynamic dateCreated;
@dynamic heading;
@dynamic latitude;
@dynamic longitude;
@dynamic speed;

+ (NSFetchRequest<LocationItem *> *)fetchRequest {
    return [NSFetchRequest fetchRequestWithEntityName:@"LocationItem"];
}

- (void)addRecord:(LocationItemData *)locationItemData moc:(NSManagedObjectContext *)moc{
    [ self setDateCreated: ( locationItemData.dateCreated == nil ? [NSDate date] : locationItemData.dateCreated ) ];
    [ self setHeading: locationItemData.heading ];
    [ self setLatitude: locationItemData.locationCoor2D.latitude ];
    [ self setLongitude: locationItemData.locationCoor2D.longitude ];
    [ self setSpeed: locationItemData.speed ];

    NSError* error = nil;
    [ moc save: &error ];
    if( error == nil ){
        printf( "LocationItem:addRecord called OK\n" );
    }
    else{
        NSLog(@"LocationItem:addRecord Error=<%@> Reason=<%@>", [ error localizedDescription ], [ error localizedFailureReason ]);
    }
}

+ (void)delAllRecords:(NSManagedObjectContext *)moc{
    BOOL rtnValue = FALSE;
    NSArray<LocationItem *> *locationItemArray = nil;
    NSArray<LocationItemData *> *locationItemDataArray = nil;

    [ self getAllRecords: moc rtnValue: &rtnValue locationItemArray: &locationItemArray locationItemDataArray: &locationItemDataArray ];
    if( rtnValue ){
        for( LocationItem *locationItem in locationItemArray){
            [ moc deleteObject: locationItem ];
        }
        
        NSError* error = nil;
        [ moc save: &error ];
        if( error == nil ){
            printf( "LocationItem:delAllRecords called OK\n" );
        }
        else{
            NSLog(@"LocationItem:delAllRecords Error=<%@> Reason=<%@>", [ error localizedDescription ], [ error localizedFailureReason ]);
        }
    }
    else{
        printf( "LocationItem:delAllRecords called NG\n" );
    }
}

+ (void)getAllRecords:(NSManagedObjectContext *)moc rtnValue:(BOOL *)rtnValue locationItemArray:(NSArray<LocationItem *> **)locationItemArray locationItemDataArray:(NSArray<LocationItemData *> **)locationItemDataArray{
    *rtnValue = FALSE;
    *locationItemArray = nil;
    *locationItemDataArray = nil;
    
    NSFetchRequest<LocationItem *> *locationItemFetchReq = [ LocationItem fetchRequest ];
    
    NSError* error = nil;
    NSArray* records = [ moc executeFetchRequest:locationItemFetchReq error:&error ] ;
    if( error == nil ){
        if( records != nil && records.count > 0 ){
            NSMutableArray* locationItemDataLocal = [ NSMutableArray arrayWithCapacity: records.count ];
            for( LocationItem* locationItem in records ){
                CLLocationCoordinate2D locationCoor2D = CLLocationCoordinate2DMake(locationItem.latitude, locationItem.longitude);
                LocationItemData* locationItemData =
                [ LocationItemData initWithHeading: locationItem.heading locationCoor2D: &locationCoor2D speed: locationItem.speed dateCreated: locationItem.dateCreated ];
                [ locationItemDataLocal addObject: locationItemData ];
            }
            *locationItemArray     = records;
            *locationItemDataArray = locationItemDataLocal;
            *rtnValue = TRUE;
            printf( "LocationItem:getAllRecords called OK\n" );
        }
        else{
            *locationItemArray     = [ [ NSArray alloc ] init ];
            *locationItemDataArray = [ [ NSArray alloc ] init ];
            printf( "LocationItem:getAllRecords Cannot get records\n" );
        }
    }
    else{
        *locationItemArray     = [ [ NSArray alloc ] init ];
        *locationItemDataArray = [ [ NSArray alloc ] init ];
        NSLog(@"AppSettings:getRecord Error=<%@> Reason=<%@>", [ error localizedDescription ], [ error localizedFailureReason ]);
    }
}
@end
