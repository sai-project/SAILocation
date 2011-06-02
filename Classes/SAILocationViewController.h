//
//  SAILocationViewController.h
//  SAILocation
//
//  Created by hirara on 11/05/12.
//  Copyright 2011 IAMAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Location_Updater.h"

@interface SAILocationViewController : UIViewController <MKMapViewDelegate>{
    
    Location_Updater *locator;
    UILabel *poslabel;
    UILabel *hereLabel, *here2Label;
    UIImageView *mapImgView;
    MKMapView *mapView;
}

@property (nonatomic, retain) Location_Updater *locator;
@property (nonatomic, retain) UILabel *posLabel;
@property (nonatomic, retain) UILabel *hereLabel;
@property (nonatomic, retain) UILabel *here2Label;
@property (nonatomic, retain) UIImageView *mapImgView;
@property (nonatomic, retain) MKMapView *mapView;

-(void) updateLocation;
-(double)distance:(double)lat1 :(double)lon1 :(double)lat2 :(double)lon2 :(double *)ang;

@end
