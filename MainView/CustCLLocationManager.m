//
//  CustCLLocationManager.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-15.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "CustCLLocationManager.h"

@implementation CustCLLocationManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        _updateInterVal = -1;
        _lastTimeStamp  = nil;
    }
    return self;
}

- (void)resetHeadingOrientation:(UILabel *)uiLabel{
    printf ( "CustCLLocationManager: resetHeadingOrientation called " );
    
    switch( UIApplication.sharedApplication.statusBarOrientation ){
        case UIInterfaceOrientationUnknown :                printf("unknown\n") ; break;
        case UIInterfaceOrientationPortrait :               printf("portrait\n") ; break;
        case UIInterfaceOrientationPortraitUpsideDown :     printf("portraitUpsideDown\n") ; break;
        case UIInterfaceOrientationLandscapeLeft :          printf("landscapeLeft\n") ; break;
        case UIInterfaceOrientationLandscapeRight :         printf("landscapeRight\n") ; break;
    }
    [self stopUpdatingLocation];
    
    self.headingOrientation = (CLDeviceOrientation)(UIApplication.sharedApplication.statusBarOrientation);
    if( self.headingOrientation != UIDeviceOrientationUnknown ){
        switch( self.headingOrientation ){
            case UIDeviceOrientationPortrait :              [ uiLabel setText: @"⬆"] ; break;
            case UIDeviceOrientationPortraitUpsideDown :    [ uiLabel setText: @"⬇"] ; break;
            case UIDeviceOrientationLandscapeLeft :         [ uiLabel setText: @"➡"] ; break;
            case UIDeviceOrientationLandscapeRight :        [ uiLabel setText: @"⬅"] ; break;
            default:                                        [ uiLabel setText: @"???"] ; break;
        }
    }
    else{
        [ uiLabel setText: @""] ;
    }
}
@end
