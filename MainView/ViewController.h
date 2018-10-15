//
//  ViewController.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-14.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "CustCLLocationManager.h"
#import "LockUsage.h"
#import "NaviUsage.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate>{
    @private CustCLLocationManager* locationManager;
    @private CNaviUsage* naviUsage;
    @private CLockUsage* lockOrientation;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnLockOrientation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnNaviUsage;
@property (weak, nonatomic) IBOutlet UILabel *authorizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *headingOrientation;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

- (void) initNavi;
@end

