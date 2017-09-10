//
//  WeekViewController.m
//  Weather
//
//  Created by pasyukevich on 05.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "WeekViewController.h"
#import "WeatherViewController.h"
#import <AFNetworking.h>
#import "WeatherUpdate.h"
#import <CoreLocation/CoreLocation.h>
#import "WeekWeatherUpdate.h"
#import "TableViewCell.h"
#import "WeatherManager.h"

@interface WeekViewController () <CLLocationManagerDelegate>
@property (nonatomic) NSArray *weekArray;
@property (nonatomic, strong) WeatherManager *weatherManager;

@end

@implementation WeekViewController {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getWeatherWithCoordinates:(CLLocationCoordinate2D)coordinates {
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@lat=%f&lon=%f%@", @"http://api.openweathermap.org/data/2.5/forecast?" , coordinates.latitude, coordinates.longitude, @"&units=metric&APPID=c5d4c2e7b159d4fa7b5dddd06d157141"];
    
    [self.weatherManager getWeatherWithURL:urlString controller:self completion:^(id responseObject) {
        NSError *error;
        WeekWeatherUpdate *weather = [[WeekWeatherUpdate alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"%@",weather);
        self.weekArray = weather.weather;
        
        [self.tabelView reloadData];
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = locations[0];
    if (!didReciveLocation) {
        [self getWeatherWithCoordinates:currentLocation.coordinate];
        didReciveLocation = YES;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.weekArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = (TableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    WeatherUpdate *weather = self.weekArray[indexPath.row];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"MMM d\nHH:mm";
    cell.dayLabel.text = [NSString stringWithFormat:@"Day:\n%@",[formatter stringFromDate:weather.dayWeek]];
    cell.temoLabel.text = [NSString stringWithFormat:@"Temp:\n%ld", (long)weather.temp];
    cell.pressureLabel.text = [NSString stringWithFormat:@"Pressure:\n%.0f", weather.pressure];
    cell.windLabel.text = [NSString stringWithFormat:@"Wind:\n %.1f",weather.speed];
    cell.weatherLabel.text = ((Weather *)weather.weather[0]).main;
    
    return cell;
}

@end
