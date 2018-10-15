//
//  Reachability.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-16.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//


#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Reachability.h"

@implementation Reachability
+ (void)isConnectedToNetwork:(BOOL *)isReachable isCellData:(BOOL *)isCellData{
    *isReachable = FALSE;
    *isCellData  = FALSE;
    
    struct sockaddr_in zeroAddress;
    memset(&zeroAddress, 0x0, sizeof( zeroAddress ));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef networkReachabilityRef = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (struct sockaddr*)&zeroAddress);
    if( networkReachabilityRef != nil ){
        SCNetworkReachabilityFlags networkReachabilityFlags;
        memset(&networkReachabilityFlags, 0x0, sizeof( networkReachabilityFlags ));
        if( SCNetworkReachabilityGetFlags(networkReachabilityRef, &networkReachabilityFlags) == TRUE ){
            *isReachable = ( (networkReachabilityFlags & (kSCNetworkReachabilityFlagsReachable)) && ((networkReachabilityFlags & (kSCNetworkReachabilityFlagsConnectionRequired)) == 0 ) ) ? TRUE : FALSE;
            *isCellData  = ( networkReachabilityFlags & (kSCNetworkReachabilityFlagsIsWWAN) )    ? TRUE : FALSE;
        }
        CFRelease( networkReachabilityRef );
        networkReachabilityRef = nil;
    }
}
@end
