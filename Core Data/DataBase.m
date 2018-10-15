//
//  DataBase.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "CoreDataManager.h"
#import "DataBase.h"
#import "LocationItem+CoreDataProperties.h"

@interface DataBase()
-(void) printMngObjCnt: (NSString*)extraStr;
@end

@implementation DataBase
- (instancetype)init
{
    self = [super init];
    if (self) {
        coreDataMngr = [ CoreDataManager initWithModelName: @"DataModel" ] ;
        if( coreDataMngr != nil ){
            moc = coreDataMngr.managedObjectContext ;
        }
        else{
            moc = nil;
        }
    }
    return self;
}

- (BOOL)getAppSettings:(AppSettingsData **)appSettingData{
    BOOL rtnValue = FALSE;
    AppSettings* appSettings = nil;

    [ AppSettings getRecord: moc rtnValue:&rtnValue appSettings: &appSettings appSettingsData: appSettingData ] ;

    return rtnValue;
}

- (BOOL)saveAppSettings:(AppSettingsData *)appSettingData{
    BOOL rtnValue = FALSE;
    AppSettings* appSettings = nil;
    AppSettings* appSettingsLocal = nil;
    AppSettingsData* appSettingDataLocal = nil;
    
    [ AppSettings getRecord: moc rtnValue:&rtnValue appSettings: &appSettingsLocal appSettingsData: &appSettingDataLocal ] ;
    if( rtnValue == FALSE ){
        appSettingsLocal = [ coreDataMngr makeAppSettings: moc ];
    }
    if( appSettingsLocal != nil ){
        appSettings = appSettingsLocal;
        [ appSettings saveRecord: appSettingData moc: moc ];
        rtnValue = TRUE;
    }
    
    return rtnValue;
}

- (void)addLocationItem:(LocationItemData *)locationItemData{
    LocationItem* locationItem = [ coreDataMngr makeLocationItem: moc ];
    [ locationItem addRecord: locationItemData moc: moc ];
    [ self clearAllMngObjs ];
}

- (void)delLocationItems{
    [ LocationItem delAllRecords: moc ];
}

- (BOOL)getLocationItems:(NSArray<LocationItemData *> **)locationItemDataArray{
    BOOL rtnValue = FALSE;
    NSArray<LocationItem *> *locationItemArray = nil;
    
    [ LocationItem getAllRecords: moc rtnValue: &rtnValue locationItemArray: &locationItemArray locationItemDataArray: locationItemDataArray ];

    return rtnValue;
}
- (void)clearAllMngObjs{
    [ self printMngObjCnt: @"clearAllMngObjs called entry" ];
    [ coreDataMngr.managedObjectContext reset ];
    [ self printMngObjCnt: @"clearAllMngObjs called exit" ];
}

- (void)printMngObjCnt:(NSString *)extraStr{
    NSLog( @"%@ %lu", extraStr, (unsigned long)coreDataMngr.managedObjectContext.registeredObjects.count );
}
@end
