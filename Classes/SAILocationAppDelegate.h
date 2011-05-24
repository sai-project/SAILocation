//
//  SAILocationAppDelegate.h
//  SAILocation
//
//  Created by hirara on 11/05/12.
//  Copyright 2011 IAMAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAILocationViewController;

@interface SAILocationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SAILocationViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SAILocationViewController *viewController;

@end

