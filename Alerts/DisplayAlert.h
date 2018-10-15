//
//  DisplayAlert.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-15.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayAlert: NSObject{
    @private UIViewController* currentVC;
}

- (void) showAlertLocation: (NSString*)title message:(NSString*)message viewController:(UIViewController*)viewController;
- (void) showAlertNetwork: (NSString*)title message:(NSString*)message viewController:(UIViewController*)viewController;
- (void) showDelAllLocationItems: (NSString*)title message:(NSString*)message viewController:(UIViewController*)viewController;
@end
