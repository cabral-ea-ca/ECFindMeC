//
//  CoreDataManager.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppSettings+CoreDataClass.h"
#import "LocationItem+CoreDataClass.h"

@interface CoreDataManager : NSObject{
    @private NSString* modelName;
    @private NSManagedObjectModel* managedObjectModel;
    @private NSPersistentStoreCoordinator* persistentStoreCoordinator;
}

@property (nonatomic, readonly) NSManagedObjectContext* managedObjectContext;

+(instancetype) initWithModelName: (NSString*)modelName;
- (AppSettings *)makeAppSettings: (NSManagedObjectContext *)moc;
- (LocationItem *)makeLocationItem: (NSManagedObjectContext *)moc;
@end
