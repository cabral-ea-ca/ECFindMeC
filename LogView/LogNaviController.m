//
//  LogNaviController.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "LogNaviController.h"

@implementation LogNaviController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (LogNaviController *)storyboardInstance{
    UIStoryboard* uiStoryboard = [ UIStoryboard storyboardWithName:NSStringFromClass( [self class] ) bundle:nil ];
    LogNaviController* logNaviController = nil;
    if( uiStoryboard != nil ){
        logNaviController = [ uiStoryboard instantiateViewControllerWithIdentifier:NSStringFromClass( [self class] ) ];
    }
    
    return logNaviController;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
