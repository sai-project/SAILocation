//
//  Location_Updater.m
//  METAMO
//
//  Created by hirara on 09/08/20.
//  Copyright 2009 IAMAS. All rights reserved.
//

#import "Location_Updater.h"


@implementation Location_Updater

@synthesize latStr,lonStr, locationManager,locState, lat, lon;

-(id)init:(id)Observer
{
	self = [super init];
	if(self != nil){
		if(locationManager == nil){
			locationManager = [[CLLocationManager alloc] init];
			locationManager.delegate = self;
			locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//			locationManager.desiredAccuracy = [[setupInfo objectForKey:kSetupInfoKeyAccuracy] doubleValue];
			[locationManager startUpdatingLocation];
			[[NSNotificationCenter defaultCenter] addObserver:Observer selector:@selector(updateLocation) name:@"update_location" object:nil];
		} else {
			[locationManager startUpdatingLocation];
			[[NSNotificationCenter defaultCenter] addObserver:Observer selector:@selector(updateLocation) name:@"update_location" object:nil];
			return self;
		}
	}
	latStr = @"0.0";
	lonStr = @"0.0";
	locState = 0; // 0:updating 1:out of area 2:error
	return self;
}

-(void)stopUpdating:(id)Observer
{
	[[NSNotificationCenter defaultCenter] removeObserver:Observer];
	[self.locationManager stopUpdatingLocation];
	
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSMutableString *errorString = [[[NSMutableString alloc] init] autorelease];
	
	if([error code] != kCLErrorLocationUnknown){
		[self.locationManager stopUpdatingLocation];
	}
	
	self.latStr = @"0.0";
	self.lonStr = @"0.0";
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alart" message:@"位置情報が取得できません" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	[alert show];
	
	[alert release];
	locState = 2;

}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newloc fromLocation:(CLLocation *)fromloc
{
    NSDate* eventDate = newloc.timestamp;
	
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
	
    if (abs(howRecent) < 2.0)
		
    {
		
		lat = newloc.coordinate.latitude;
		lon = newloc.coordinate.longitude;
		
		self.latStr = [NSString stringWithFormat:@"%.4f", lat];
		self.lonStr = [NSString	stringWithFormat:@"%.4f", lon];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"update_location" object:self userInfo:nil];

    }
	locState = 0;
	
	
}


	
@end
