//
//  DataBase.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataManager.h"

@interface DataBase : NSObject{
    @private CoreDataManager* coreDataMngr;
    @private NSManagedObjectContext* moc;
}

-(BOOL) getAppSettings:(AppSettingsData**) appSettingData;
-(BOOL) saveAppSettings:(AppSettingsData*) appSettingData;
-(void) addLocationItem:(LocationItemData*) locationItemData;
-(void) delLocationItems;
-(BOOL) getLocationItems: (NSArray<LocationItemData*> **)locationItemDataArray;
-(void) clearAllMngObjs;
@end
