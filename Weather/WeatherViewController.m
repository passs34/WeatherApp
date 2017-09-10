//
//  WeatherViewController.m
//  Weather
//
//  Created by pasyukevich on 05.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "WeatherViewController.h"
#import <AFNetworking.h>
#import "WeatherUpdate.h"
#import <CoreLocation/CoreLocation.h>
#import "WeatherManager.h"

@interface WeatherViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) WeatherManager *weatherManager;
@end

@implementation WeatherViewController {
    CLLocationManager *locationManager;
    BOOL didReciveLocation;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    didReciveLocation = NO;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    self.weatherManager = [[WeatherManager alloc] init];
   
}

-(void)getWeatherWithCoordinates:(CLLocationCoordinate2D)coordinates {
    NSString *urlString = [NSString stringWithFormat:@"%@lat=%f&lon=%f%@", @"http://api.openweathermap.org/data/2.5/weather?" , coordinates.latitude, coordinates.longitude, @"&units=metric&APPID=c5d4c2e7b159d4fa7b5dddd06d157141"];
    
    [self.weatherManager getWeatherWithURL:urlString controller:self completion:^(id responseObject) {
        NSError *error;
        WeatherUpdate *weather = [[WeatherUpdate alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"%@",weather);
        [self updateUIWithJSON:weather];
    }];
}

-(void)updateUIWithJSON:(WeatherUpdate *)weather {
    
    self.labelCity.text = weather.city;
    self.labelTemp.text = [NSString stringWithFormat:@"%ld", (long)weather.temp];
    self.labelWeather.text = ((Weather *)weather.weather[0]).main;
    self.labelPressure.text = [NSString stringWithFormat:@"Pressure:\n%.0f", weather.pressure];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    self.labelSunset.text = [NSString stringWithFormat:@"Sunset:\n %@",[formatter stringFromDate:weather.sunset]];
    self.labelSunrise.text = [NSString stringWithFormat:@"Sunrise:\n %@",[formatter stringFromDate:weather.sunrise]];
    self.labelWind.text = [NSString stringWithFormat:@"Wind:\n %.1f",weather.speed];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations[0];
    if (!didReciveLocation) {
        [self getWeatherWithCoordinates:currentLocation.coordinate];
        didReciveLocation = YES;
        
    }
}

@end
