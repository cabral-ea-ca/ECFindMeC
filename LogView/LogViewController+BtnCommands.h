//
//  LogViewController+BtnCommands.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController (BtnCommands)
- (IBAction)buttonGotoPrevView:(UIBarButtonItem *)sender;
- (IBAction)buttonDeleteAll:(UIBarButtonItem *)sender;
- (IBAction)buttonGotoTopRec:(UIBarButtonItem *)sender;
- (IBAction)buttonGotoLastRec:(UIBarButtonItem *)sender;
- (IBAction)buttonGotoNextRec:(UIBarButtonItem *)sender;
- (IBAction)buttonGotoPrevRec:(UIBarButtonItem *)sender;
@end
