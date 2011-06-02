//
//  SAILocationViewController.m
//  SAILocation
//
//  Created by hirara on 11/05/12.
//  Copyright 2011 IAMAS. All rights reserved.
//

#import "SAILocationViewController.h"

@implementation SAILocationViewController

@synthesize locator;
@synthesize hereLabel, here2Label, posLabel;
@synthesize mapImgView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    locator = [[Location_Updater alloc] init:self];
    
    //setup background image
    mapImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgmap.png"]];
    [self.view addSubview:mapImgView];

	
	hereLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 40, 14)];
	hereLabel.font = [UIFont fontWithName:@"Helvetica-Bold"  size:12.0f];
	hereLabel.backgroundColor = [UIColor clearColor];
	hereLabel.textColor = [UIColor whiteColor];
	hereLabel.text = @"here";
	[self.view addSubview:hereLabel];
    
	here2Label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 40, 14)];
	here2Label.font = [UIFont fontWithName:@"Helvetica-Bold"  size:12.0f];
	here2Label.backgroundColor = [UIColor clearColor];
	here2Label.textColor = [UIColor whiteColor];
	here2Label.text = @"alt.here";
	[self.view addSubview:here2Label];
	
	posLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 310, 14)];
	posLabel.font = [UIFont fontWithName:@"Helvetica-Bold"  size:12.0f];
	posLabel.backgroundColor = [UIColor clearColor];
	posLabel.textColor = [UIColor whiteColor];
	posLabel.text = @"current location";
	[self.view addSubview:posLabel];	

    
}

-(void)updateLocation
{
	NSLog(@"Update location notify\n");
	
	double lat_iamas = 35.385768;
	double lon_iamas = 136.621006;
	
	posLabel.text = [NSString stringWithFormat:@"%f : %f",  locator.lat ,locator.lon];
	
	double lat = locator.lat;
	double lon = locator.lon;
	double ang;
	
	if(locator.locState == 2){
		[locator stopUpdating:self];
	}
	
	/*　ヒュベニの公式を利用して、２つの座標値の距離と角度を計算する。
	 　　かなり簡易化した式ですが、下の方法よりは広い範囲で使えます。
     */
    
	double dist = [self distance:lat :lon :lat_iamas :lon_iamas :&ang];
    
	// 向きや画面上の移動量は適当なので、画面に合わせて変更してください。
	
	double factor = 1.0;
	double xpos = dist * cos(ang) * factor + 160; // 1m = 'factor' pixel, view width/2
	double ypos = dist * sin(ang) * factor + 240;
	
	[hereLabel setCenter:CGPointMake(xpos, ypos)];
    
    /* 狭い範囲の場合には、画面に表示するエリアの緯度、経度の差分をピクセル数で割り、
     　その値と現在の緯度経度から、画面上の位置を割り出すこともできる。こっちの方が簡単かも。
	 */
    
	// 座標は適当でアスペクト比もあってません。変更してください。
	double xdrft = ((35.386139 - 35.384913) ) / 320.0;
	double ydrft = ((136.620553 - 136.621771) ) / 480.0;
	
	double clat = 35.385768;
	double clon = 136.621006;
	double px,py;
	
	px = 160.0 - (lat - clat) / xdrft ;
	py = 240.0 + (lon - clon) / ydrft ;
    
	[here2Label setCenter:CGPointMake(px, py)];
	
}


-(double)distance:(double)lat1 :(double)lon1 :(double)lat2 :(double)lon2 :(double *)ang;
{
	// ヒュベニの公式
	double rlat1 = lat1 * M_PI / 180.0;
	double rlon1 = lon1 * M_PI / 180.0; 
	double rlat2 = lat2 * M_PI / 180.0;
	double rlon2 = lon2 * M_PI / 180.0;
	
	// 平均緯度
	double latAve = (rlat1 + rlat2) / 2.0;
	// 緯度差
	double latDiff = rlat1 - rlat2;
	// 経度差算
	double lonDiff = rlon1 - rlon2;
	double sinLat = sin(latAve);
	
	double w2 = 1.0 - 0.00669438 * (sinLat*sinLat);// 
	double m = 6335439.327 / sqrt(w2*w2*w2); // 子午線曲率半径
	double n = 6378137.0 / sqrt(w2); // 卯酉線曲率半径
	
	double t1 = m * latDiff;
	double t2 = n * cos(latAve) * lonDiff;
	double dist = sqrt((t1*t1) + (t2*t2));
	
	*ang = atan2(t2,t1);
	
	return dist;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [locator release];
    [hereLabel release];
    [here2Label release];
    [posLabel release];
    [super dealloc];
}

@end
