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
#import "Urlmanagers.h"
#import "LocationManager.h"

@interface WeatherViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) WeatherManager *weatherManager;

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weatherManager = [[WeatherManager alloc] init];
    [[LocationManager sharedInstance] startUpdatingLocation];
    [self getWeatherWithCoordinates:[LocationManager sharedInstance].currentLocation.coordinate];
}

-(void)getWeatherWithCoordinates:(CLLocationCoordinate2D)coordinates {
    NSString *urlString = [NSString stringWithFormat:@"%@lat=%f&lon=%f%@", BASEURL , coordinates.latitude, coordinates.longitude, BASEURL2];
    
    [self.weatherManager getWeatherWithURL:urlString controller:self completion:^(id responseObject) {
        NSError *error;
        NSUInteger i = [responseObject count];
        NSLog(@"%lu", (unsigned long)i);
WeatherUpdate *weather = [[WeatherUpdate alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"%@",weather);
        if (i <= 0 ) {
           WeatherManager *manager = [[WeatherManager alloc] init];
            [manager showErrorServerAlert:error controller:self];
        } else {
            [self updateUIWithJSON:weather];}
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

@end
