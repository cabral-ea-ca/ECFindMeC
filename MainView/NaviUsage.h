//
//  NaviUsage.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-16.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustCLLocationManager.h"

@interface CNaviUsage: NSObject{
    enum NaviUsageType {
    kUnknownNavi = -1,
    kNoNavi  = 0,
    kUseForWalking = 1,
    kFastNavigation = 2,
    kSFastNavigation = 3,
    } ;
    
    @private NSArray *typeStringTable;
}

@property (nonatomic) enum NaviUsageType naviUsageType;

- (NSString*) naviUsageDesc;
- (void) startNavi: (CustCLLocationManager*) locationManager;
- (void) switchNavi: (CustCLLocationManager*) locationManager;
@end
