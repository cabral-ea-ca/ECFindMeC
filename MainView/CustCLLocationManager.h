//
//  CustCLLocationManager.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-15.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#ifndef CustCLLocationManager_h
#define CustCLLocationManager_h

@interface CustCLLocationManager: CLLocationManager{
}
@property(nonatomic) int updateInterVal;
@property(nonatomic, strong) NSDate* lastTimeStamp;

- (void) resetHeadingOrientation: (UILabel*)uiLabel;
@end

#endif /* CustCLLocationManager_h */
