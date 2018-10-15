//
//  Reachability.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-16.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Reachability : NSObject

+(void) isConnectedToNetwork: (BOOL*) isReachable isCellData:(BOOL*) isCellData;
@end
