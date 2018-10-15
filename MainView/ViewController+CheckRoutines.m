//
//  ViewController+CheckRoutines.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-18.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "ViewController+CheckRoutines.h"
#import "../AppDelegate.h"
#import "../Library API/Reachability.h"

@implementation ViewController (CheckRoutines)
- (void) checkNetwork{
    printf ( "ViewController: checkNetwork called\n" );
    [ self initNavi];
    [ naviUsage startNavi:locationManager ];
    
    BOOL isReachable = FALSE, isCellData = FALSE;
    [ Reachability isConnectedToNetwork:&isReachable isCellData:&isCellData ];
    if( isReachable ){
        printf("Internet Connection Available!\n");
        [ self.authorizationLabel setText: @"✔"] ;
    }else{
        printf("Internet Connection not Available!\n");
        [ self.authorizationLabel setText: @"✓"];
        if( self.navigationController.visibleViewController == self && ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert == nil ){
            DisplayAlert* displayAlert = [ [DisplayAlert alloc] init ];
            ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert = displayAlert;
            [ displayAlert showAlertNetwork:@"Network" message: @"Kindly turn on Wi-Fi or Cellular Data for map updates" viewController:self];
            // displayAlert = nil;
        }
    }
}

- (void)checkLocationServ{
    printf ( "ViewController: checkLocationServ called\n" );
    switch( CLLocationManager.authorizationStatus){
        case kCLAuthorizationStatusAuthorizedAlways :
            printf( "authorizedAlways not allowed\n" );
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse :{
            UIColor* uiColor = [ UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1 ];
            [ self.authorizationLabel setTextColor:uiColor ];
            // uiColor = nil;
        }
            [ locationManager resetHeadingOrientation: [ self headingOrientation ] ];
            [ self checkNetwork ];
            break;
            
        case kCLAuthorizationStatusDenied :
            [ self.authorizationLabel setText: @"✖"];
        {
            UIColor* uiColor = [ UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:1 ];
            [ self.authorizationLabel setTextColor:uiColor ];
            // uiColor = nil;
        }
            if( self.navigationController.visibleViewController == self && ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert == nil ){
                DisplayAlert* displayAlert = [ [DisplayAlert alloc] init];
                ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert = displayAlert;
                [ displayAlert showAlertLocation:@"Location Services Setting" message: @"Kindly allow the app to use it" viewController:self];
                // displayAlert = nil;
            }
            break;
            
        case kCLAuthorizationStatusNotDetermined :
            [ self.authorizationLabel setText: @"❓"];
        {
            UIColor* uiColor = [ UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:1 ];
            [ self.authorizationLabel setTextColor:uiColor ];
            // uiColor = nil;
        }
            [ locationManager requestWhenInUseAuthorization ];
            break;
            
        case kCLAuthorizationStatusRestricted :
            [ self.authorizationLabel setText: @"❔"];
        {
            UIColor* uiColor = [ UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5 ];
            [ self.authorizationLabel setTextColor:uiColor ];
            // uiColor = nil;
        }
            break;
    }
}
@end
