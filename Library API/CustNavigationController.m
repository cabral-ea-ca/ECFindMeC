//
//  CustNavigationController.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-17.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "CustNavigationController.h"

@implementation CustNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    if( self.visibleViewController != nil ){
        return self.visibleViewController.shouldAutorotate;
    }
    
    return super.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    if( self.visibleViewController != nil ){
        return self.visibleViewController.preferredInterfaceOrientationForPresentation;
    }
    
    return super.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if( self.visibleViewController != nil ){
        return self.visibleViewController.supportedInterfaceOrientations;
    }
    
    return super.supportedInterfaceOrientations;
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
