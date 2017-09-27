//
//  LocationManager.m
//  Weather
//
//  Created by admin on 26.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager
@synthesize locationManager;

+(LocationManager *) sharedInstance {
    
    static LocationManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if(self) {
    self.locationManager = [CLLocationManager new];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:kCLDistanceFilterNone];
    [self.locationManager setHeadingFilter:kCLHeadingFilterNone];
    [self.locationManager startUpdatingLocation];
    
    }
    return self;
}

- (void)startUpdatingLocation
{
    NSLog(@"Starting location updates");
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location service failed with error %@", error);
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *>*)locations
{
    CLLocation *location = [locations lastObject];
    NSLog(@"Latitude %+.6f, Longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);
    self.currentLocation = location;
}

@end
