//
//  LockUsage.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-16.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "LockUsage.h"

@interface CLockUsage()
- (void) lockUsageForLock;
- (void) lockUsageForUnlock;
@end

@implementation CLockUsage
- (instancetype)init
{
    self = [super init];
    if (self) {
        _lockUsageType = kUnlocked;
        typeStringTable = [ NSArray arrayWithObjects: @"Locked", @"Unlocked", nil];
    }
    return self;
}

- (NSString *)lockUsageDesc{
    return [ typeStringTable objectAtIndex:_lockUsageType ];
}

- (void)lockUsageForLock{
    enum LockType OldValue = _lockUsageType;
    _lockUsageType = kLocked;
    printf( "CLockUsage: lockUsageForLock called %d -> %d\n", OldValue, _lockUsageType );
}

- (void)lockUsageForUnlock{
    enum LockType OldValue = _lockUsageType;
    _lockUsageType = kUnlocked;
    printf( "CLockUsage: lockUsageForUnlock called %d -> %d\n", OldValue, _lockUsageType );
}

- (void)switchLock{
    printf( "CLockUsage: switchLock called\n" );
    switch( _lockUsageType ){
        case kUnknownLock:  printf( "What happened???\n" ); break;
        case kLocked:       [ self lockUsageForUnlock]; break;
        case kUnlocked:     [ self lockUsageForLock]; break;
    }
}
@end
