//
//  DisplayAlert.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-15.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "../AppDelegate.h"
#import "CustAlertController.h"
#import "DisplayAlert.h"
#import "../LogView/LogViewController.h"

@interface DisplayAlert()
- (void) justClose;
- (void) jumpToURLAndClose: (NSURL*) urlStr;
@end

@implementation DisplayAlert
-(void)justClose{
    currentVC = nil;
    ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert = nil ;
}

-(void)jumpToURLAndClose:(NSURL *)urlStr{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (@available(iOS 10.0, *)) {
            [ UIApplication.sharedApplication openURL:urlStr options:@{} completionHandler:nil ];
        } else {
            [ UIApplication.sharedApplication openURL:urlStr ];
        }
    });
    [ self justClose ];
}

- (void)showAlertLocation:(NSString *)title message:(NSString *)message viewController:(UIViewController *)viewController{
    printf( "DisplayAlert: showAlertLocation called\n" );
    CustAlertController* alertController = [CustAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert] ;
    
    UIAlertAction* cancelAction = [ UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", comment: @"Setting action") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSURL* urlStr = [ [NSURL alloc] initWithString: @"App-Prefs:root=Privacy&path=LOCATION" ];
        [ self jumpToURLAndClose:urlStr ];
        urlStr = nil;
    }];
    
    UIAlertAction* defaultAction = [ UIAlertAction actionWithTitle:NSLocalizedString(@"OK", comment: @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [ self justClose ];
    }];
    
    [ alertController addAction:cancelAction ] ;
    [ alertController addAction:defaultAction ] ;
    currentVC = viewController;
    alertController.currentVC = viewController;
    [ viewController presentViewController:alertController animated:TRUE completion:nil ] ;
}

- (void)showAlertNetwork:(NSString *)title message:(NSString *)message viewController:(UIViewController *)viewController{
    printf( "DisplayAlert: showAlertNetwork called\n" );
    CustAlertController* alertController = [CustAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert] ;
    
    UIAlertAction* cancelAction = [ UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", comment: @"Setting action") style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        NSURL* urlStr = [ [NSURL alloc] initWithString: @"App-Prefs:root" ];
        [ self jumpToURLAndClose:urlStr ];
        urlStr = nil;
    }];
    
    UIAlertAction* defaultAction = [ UIAlertAction actionWithTitle:NSLocalizedString(@"OK", comment: @"OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [ self justClose ];
    }];
    
    [ alertController addAction:cancelAction ] ;
    [ alertController addAction:defaultAction ] ;
    currentVC = viewController;
    alertController.currentVC = viewController;
    [ viewController presentViewController:alertController animated:TRUE completion:nil ] ;
}

- (void)showDelAllLocationItems:(NSString *)title message:(NSString *)message viewController:(UIViewController *)viewController{
    printf( "DisplayAlert: showDelAllLocationItems called\n" );
    CustAlertController* alertController = [CustAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert] ;
    
    UIAlertAction* cancelAction = [ UIAlertAction actionWithTitle:NSLocalizedString(@"Yes", comment: @"Yes action") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [ ((AppDelegate*)(UIApplication.sharedApplication.delegate)).database delLocationItems ];
        LogViewController* logVC = ( LogViewController* ) self->currentVC ;
        [ logVC initAllItems:TRUE ];
        [ self justClose ];
    }];
    
    UIAlertAction* defaultAction = [ UIAlertAction actionWithTitle:NSLocalizedString(@"No", comment: @"No action") style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [ self justClose ];
    }];
    
    [ alertController addAction:cancelAction ] ;
    [ alertController addAction:defaultAction ] ;
    currentVC = viewController;
    alertController.currentVC = viewController;
    [ viewController presentViewController:alertController animated:TRUE completion:nil ] ;
}
@end
