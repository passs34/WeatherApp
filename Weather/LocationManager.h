//
//  LocationManager.h
//  Weather
//
//  Created by admin on 26.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

+(LocationManager *) sharedInstance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

- (void)startUpdatingLocation;

@end
