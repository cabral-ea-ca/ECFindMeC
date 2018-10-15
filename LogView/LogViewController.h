//
//  LogViewController.h
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Core Data/LocationItemData.h"

@interface LogViewController : UIViewController{
    @private NSArray<LocationItemData *> *locationItemDataArray;
    @private int currentRec;
}

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *recLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedDegreeLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(void) initAllItems: (BOOL)getLocationItems;
-(void) updateViewLabelsMap;
@end
