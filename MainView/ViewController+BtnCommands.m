//
//  ViewController+BtnCommands.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-18.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "../AppDelegate.h"
#import "LogNaviController.h"
#import "ViewController+BtnCommands.h"

@implementation ViewController (BtnCommands)
- (IBAction)buttonOrientHeading:(UIBarButtonItem *)sender{
    printf( "ViewController: buttonOrientHeading called\n" );
    [ locationManager resetHeadingOrientation: [ self headingOrientation ] ];
}

- (IBAction)buttonLockUsage:(UIBarButtonItem *)sender{
    printf( "ViewController: buttonNaviUsage called\n" );
    [ lockOrientation switchLock ];
    [ sender setTitle: lockOrientation.lockUsageDesc ];
}

- (void)buttonNaviUsage:(UIBarButtonItem *)sender{
    printf( "ViewController: buttonNaviUsage called\n" );
    [ naviUsage switchNavi:locationManager ];
    [ sender setTitle: naviUsage.naviUsageDesc ];
    [ self initNavi ];
}

- (void)buttonLogs:(UIBarButtonItem *)sender{
    printf( "ViewController: buttonLogs called\n" );
    LogNaviController* logNaviController = [ LogNaviController storyboardInstance ];
    if( logNaviController != nil ){
        naviUsage.naviUsageType = kNoNavi;
        [ self.btnNaviUsage setTitle:naviUsage.naviUsageDesc ] ;
        [ self initNavi ];
        [ naviUsage startNavi:locationManager ];
        ((AppDelegate*)(UIApplication.sharedApplication.delegate)).inheritedSpan = self.mapView.region.span;
        [ self presentViewController:logNaviController animated:TRUE completion:nil ];
    }
    else{
        printf( "Cannot create logNaviController\n" );
    }
}
@end
