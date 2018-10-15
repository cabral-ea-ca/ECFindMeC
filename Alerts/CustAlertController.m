//
//  CustAlertController.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-18.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "CustAlertController.h"

@implementation CustAlertController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _currentVC = nil;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _currentVC = nil;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate{
    if( self.currentVC != nil ){
        return self.currentVC.shouldAutorotate;
    }
    
    return super.shouldAutorotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    if( self.currentVC != nil ){
        return self.currentVC.preferredInterfaceOrientationForPresentation;
    }
    
    return super.preferredInterfaceOrientationForPresentation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    if( self.currentVC != nil ){
        return self.currentVC.supportedInterfaceOrientations;
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
