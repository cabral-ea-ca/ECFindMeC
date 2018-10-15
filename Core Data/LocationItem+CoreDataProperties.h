//
//  LocationItem+CoreDataProperties.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

#import "LocationItemData.h"
#import "LocationItem+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface LocationItem (CoreDataProperties)

+ (NSFetchRequest<LocationItem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateCreated;
@property (nonatomic) double heading;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) int16_t speed;

-(void) addRecord: (LocationItemData*)locationItemData moc: (NSManagedObjectContext*)moc;
+(void) delAllRecords: (NSManagedObjectContext*)moc;
+(void) getAllRecords: (NSManagedObjectContext*)moc rtnValue:(BOOL*) rtnValue locationItemArray: (NSArray<LocationItem*> **)locationItemArray locationItemDataArray: (NSArray<LocationItemData*> **)locationItemDataArray;
@end
NS_ASSUME_NONNULL_END
