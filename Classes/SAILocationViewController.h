//
//  SAILocationViewController.h
//  SAILocation
//
//  Created by hirara on 11/05/12.
//  Copyright 2011 IAMAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location_Updater.h"

@interface SAILocationViewController : UIViewController {
    
    Location_Updater *locator;
    UILabel *poslabel;
    UILabel *hereLabel, *here2Label;

}

@property (nonatomic, retain) Location_Updater *locator;
@property (nonatomic, retain) UILabel *posLabel;
@property (nonatomic, retain) UILabel *hereLabel;
@property (nonatomic, retain) UILabel *here2Label;

-(void) updateLocation;
-(double)distance:(double)lat1 :(double)lon1 :(double)lat2 :(double)lon2 :(double *)ang;

@end

