//
//  LogViewController+BtnCommands.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "../AppDelegate.h"
#import "LogViewController+BtnCommands.h"

@implementation LogViewController (BtnCommands)
- (IBAction)buttonGotoPrevView:(UIBarButtonItem *)sender {
    printf( "LogViewController: buttonGotoPrevView called\n" );
    [ self dismissViewControllerAnimated:TRUE completion:nil ];
}

- (IBAction)buttonDeleteAll:(UIBarButtonItem *)sender {
    printf( "LogViewController: buttonDeleteAll called\n" ) ;
    if( ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert == nil ){
        DisplayAlert* displayAlert = [ [DisplayAlert alloc] init ];
        ((AppDelegate*)(UIApplication.sharedApplication.delegate)).displayAlert = displayAlert;
        [ displayAlert showDelAllLocationItems:@"Will delete all location data" message: @"OK to delete all?" viewController:self];
        // displayAlert = nil;
    }
}

- (IBAction)buttonGotoTopRec:(UIBarButtonItem *)sender {
    printf( "LogViewController: buttonGotoTopRec called\n" );
    if( locationItemDataArray.count > 0 ){
        currentRec = 0;
        [ self updateViewLabelsMap ];
    }
}

- (IBAction)buttonGotoLastRec:(UIBarButtonItem *)sender {
    printf( "LogViewController: buttonGotoLastRec called\n" );
    if( locationItemDataArray.count > 0 ){
        currentRec = (int)(locationItemDataArray.count-1);
        [ self updateViewLabelsMap ];
    }
}

- (IBAction)buttonGotoNextRec:(UIBarButtonItem *)sender {
    printf( "LogViewController: buttonGotoNextRec called\n" );
    if( locationItemDataArray.count > 0 && currentRec < locationItemDataArray.count-1 ){
        currentRec += 1;
        [ self updateViewLabelsMap ];
    }
}

- (IBAction)buttonGotoPrevRec:(UIBarButtonItem *)sender {
    printf( "LogViewController: buttonGotoPrevRec called\n" );
    if( locationItemDataArray.count > 0 && currentRec > 0 ){
        currentRec -= 1;
        [ self updateViewLabelsMap ];
    }
}
@end
