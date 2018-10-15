//
//  AppSettings+CoreDataProperties.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//
//

#import "AppSettings+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppSettings (CoreDataProperties)
@property (nonatomic) double lastHeading;
@property (nonatomic) double lastLatitude;
@property (nonatomic) double lastLatitudeDelta;
@property (nonatomic) double lastLongitude;
@property (nonatomic) double lastLongitudeDelta;
@property (nullable, nonatomic, copy) NSDate *lastUpdate;

+(NSFetchRequest<AppSettings *> *) fetchRequest;
+(void) getRecord:(NSManagedObjectContext*) moc rtnValue:(BOOL*) rtnValue appSettings:(AppSettings**)appSettings appSettingsData:(AppSettingsData**) AppSettingsData;
-(void) saveRecord:(AppSettingsData *)appSettingsData moc:(NSManagedObjectContext *)moc;
@end

NS_ASSUME_NONNULL_END
