//
//  LockUsage.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-16.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLockUsage : NSObject{
    enum LockType {
        kUnknownLock = -1,
        kLocked = 0,
        kUnlocked = 1
    };
    
    @private NSArray *typeStringTable;
}

@property (nonatomic) enum LockType lockUsageType;

- (NSString*) lockUsageDesc;
- (void) switchLock;
@end
