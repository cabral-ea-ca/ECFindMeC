//
//  CoreDataManager.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "CoreDataManager.h"

@interface CoreDataManager()
-(void) initMemberVar;
-(NSManagedObjectContext*) makeMOC;
-(NSManagedObjectModel*) makeMOM;
-(NSPersistentStoreCoordinator*) makePSC;
- (NSEntityDescription *)makeEntity:(NSString *)entityName moc:(NSManagedObjectContext *)moc;
@end

@implementation CoreDataManager
+ (instancetype)initWithModelName:(NSString *)modelName{
    CoreDataManager* thisClass = [ [ [ self class ] alloc ] init ];
    thisClass->modelName = modelName;
    [ thisClass initMemberVar ];
    
    return( thisClass ) ;
}

- (void)initMemberVar{
    managedObjectModel          = self.makeMOM;
    persistentStoreCoordinator  = self.makePSC ;
    _managedObjectContext       = self.makeMOC ;
}

- (NSManagedObjectModel *)makeMOM{
    NSManagedObjectModel* rtnMOM = nil;
    NSURL* modelURL = [ NSBundle.mainBundle URLForResource: modelName withExtension: @"momd"];
    if( modelURL != nil ){
        NSManagedObjectModel* mom =  [ [ NSManagedObjectModel alloc ] initWithContentsOfURL: modelURL ] ;
        if( mom != nil ){
            rtnMOM = mom;
        }
        else{
            printf( "makeMOM: Cannot allocate\n" );
        }
    }
    
    return rtnMOM;
}

- (NSPersistentStoreCoordinator *)makePSC{
    NSPersistentStoreCoordinator* rtnPSC = nil;
    if( managedObjectModel != nil ){
        NSPersistentStoreCoordinator* psc = [ [ NSPersistentStoreCoordinator alloc ] initWithManagedObjectModel: managedObjectModel ];
        if( psc != nil ){
            NSFileManager* filemanager = NSFileManager.defaultManager;
            NSArray* urlArray = [ filemanager URLsForDirectory: NSDocumentDirectory inDomains: NSUserDomainMask ] ;
            
            if( urlArray != nil && urlArray.count > 0 ){
                NSURL* docsDirURL = [ urlArray objectAtIndex:0 ];
                NSString* storeName = [ NSString stringWithFormat: @"%@.sqllite", modelName ];
                NSURL* pscURL = [ docsDirURL URLByAppendingPathComponent: storeName ];
                
                NSError* error = nil;
                [ psc addPersistentStoreWithType: NSSQLiteStoreType configuration: nil URL:pscURL options:nil error: &error ];
                if( error == nil ){
                    rtnPSC = psc;
                }
                else{
                    NSLog(@"Error=<%@> Reason=<%@>", [ error localizedDescription ], [ error localizedFailureReason ]);
                }
            }
            else{
                printf( "makePSC: Cannot get records\n" );
            }
        }
    }
    
    return rtnPSC;
}

- (NSManagedObjectContext*) makeMOC{
    NSManagedObjectContext* rtnMOC = nil;
    if( persistentStoreCoordinator != nil ){
        NSManagedObjectContext* moc = [ [ NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType ] ;
        if( moc != nil ){
            rtnMOC = moc;
            moc.persistentStoreCoordinator = persistentStoreCoordinator;
        }
    }
    
    return rtnMOC;
}

- (NSEntityDescription *)makeEntity:(NSString *)entityName moc:(NSManagedObjectContext *)moc{
    NSEntityDescription* entity = [ NSEntityDescription entityForName: entityName inManagedObjectContext: moc ];
    if( entity != nil ){
        NSLog( @"Entity %@ created", entityName );
    }
    else{
        NSLog( @"Entity %@ cannot create", entityName );
    }
    return ( entity ) ;
}

- (AppSettings*) makeAppSettings: (NSManagedObjectContext *)moc{
    AppSettings* rtnAppSettings = nil;
    NSEntityDescription* entity = [ self makeEntity: @"AppSettings" moc: moc ];
    if( entity != nil ){
        rtnAppSettings = [ [ AppSettings alloc ] initWithEntity:entity insertIntoManagedObjectContext: moc ];
        rtnAppSettings != nil ? printf ( "AppSettings managedObj created\n" ) : printf ( "AppSettings managedObj cannot create\n" );
    }
    
    return rtnAppSettings;
}

- (LocationItem*) makeLocationItem: (NSManagedObjectContext *)moc{
    LocationItem* rtnLocationItem = nil;
    NSEntityDescription* entity = [ self makeEntity: @"LocationItem" moc: moc ];
    if( entity != nil ){
        rtnLocationItem = [ [ LocationItem alloc ] initWithEntity:entity insertIntoManagedObjectContext: moc ];
        rtnLocationItem != nil ? printf ( "LocationItem managedObj created\n" ) : printf ( "LocationItem managedObj cannot create\n" );
    }
    
    return rtnLocationItem;
}
@end
