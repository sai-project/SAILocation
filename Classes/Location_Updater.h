//
//  Location_Updater.h
//  METAMO
//
//  Created by hirara on 09/08/20.
//  Copyright 2009 IAMAS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Location_Updater : NSObject <CLLocationManagerDelegate>{
	CLLocationManager *locationManager;
	double lat;
	double lon;
	NSString *latStr;
	NSString *lonStr;
	int	locState;

}

@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) NSString *latStr;
@property (nonatomic,retain) NSString *lonStr;
@property double lat,lon;
@property int locState;


- (id)init:(id)Observer;
- (void)stopUpdating:(id)Observer;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

@end
