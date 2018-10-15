//
//  LogViewController.m
//  ECFindMeC
//
//  Created by Ryerson Student on 2018-07-19.
//  Copyright © 2018 Ryerson Student. All rights reserved.
//

#import "LogViewController.h"
#import "../AppDelegate.h"

@interface LogViewController()
-(void) markPosition: (LocationItemData*) locationItemData;
@end

@implementation LogViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        locationItemDataArray = nil;
        currentRec = -1 ;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        locationItemDataArray = nil;
        currentRec = -1 ;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray<LocationItemData *> *locationItemDataArrayLocal = nil;
    [ ((AppDelegate*)(UIApplication.sharedApplication.delegate)).database getLocationItems: &locationItemDataArrayLocal];

    locationItemDataArray = locationItemDataArrayLocal;
    CLLocationCoordinate2D currLocation = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).defaultLocation;
    if( locationItemDataArray.count > 0 ){
        currLocation = [ locationItemDataArray objectAtIndex:0 ].locationCoor2D ;
    }
    MKCoordinateSpan span               = ((AppDelegate*)(UIApplication.sharedApplication.delegate)).inheritedSpan;
    MKCoordinateRegion region           = MKCoordinateRegionMake(currLocation, span);
    [ _mapView setRegion:region animated: FALSE ];

    [ self initAllItems:FALSE ];
}

- (void)initAllItems:(BOOL)getLocationItems{
    if( getLocationItems ){
        NSArray<LocationItemData *> *locationItemDataArrayLocal = nil;
        [ ((AppDelegate*)(UIApplication.sharedApplication.delegate)).database getLocationItems: &locationItemDataArrayLocal];
        locationItemDataArray = locationItemDataArrayLocal;
    }
    
    if( locationItemDataArray.count > 0 ){
        currentRec = 0;
        [ self updateViewLabelsMap ];
    }
    else{
        LocationItemData* locationItemData = [ LocationItemData initToDefault ];
        [ _dateLabel setText: @"-" ];
        [ _timeLabel setText: @"-" ];
        [ _recLabel  setText: @"0 / 0" ];
        [ _speedDegreeLabel setText: @"-" ];
        [ self markPosition: locationItemData ];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)markPosition:(LocationItemData *)locationItemData{
    MKPointAnnotation* annotation = [ [ MKPointAnnotation alloc ] init ] ;
    annotation.coordinate = locationItemData.locationCoor2D;
    [ _mapView removeAnnotations: _mapView.annotations ];
    [ _mapView addAnnotation: annotation ];
    
    MKMapCamera* newCamera = [ self.mapView.camera copy ] ;
    newCamera.heading      = locationItemData.heading;
    [ _mapView setCamera:newCamera animated: FALSE ];
    [ _mapView setCenterCoordinate:locationItemData.locationCoor2D animated:TRUE ];
}

- (void)updateViewLabelsMap{
    LocationItemData* locationItemData = locationItemDataArray[ currentRec ];
    
    NSDateFormatter* dateFormatter = [ [ NSDateFormatter alloc ] init];
    [ dateFormatter setTimeZone:[ NSTimeZone systemTimeZone ] ];
    [ dateFormatter setDateFormat: @"yyyy-MM-dd" ];
    [ _dateLabel setText: [ dateFormatter stringFromDate: locationItemData.dateCreated ] ];
    [ dateFormatter setDateFormat: @"h:mm:ss a zzz" ];
    [ _timeLabel setText: [ dateFormatter stringFromDate: locationItemData.dateCreated ] ];
    
    NSString* tempStr = [ NSString stringWithFormat: @"%d / %lu", currentRec+1, (unsigned long)locationItemDataArray.count ];
    [ _recLabel setText: tempStr];
    tempStr = [ NSString stringWithFormat: @"%d km/h, %0.0lf°", locationItemData.speed, locationItemData.heading ];
    [ _speedDegreeLabel setText: tempStr];
    
    [ self markPosition: locationItemData ];
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
