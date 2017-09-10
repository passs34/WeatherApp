//
//  CityViewController.m
//  Weather
//
//  Created by pasyukevich on 05.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "CityViewController.h"
#import <AFNetworking.h>
#import "WeatherUpdate.h"
#import "WeatherViewController.h"
#import "WeatherManager.h"
@interface CityViewController () <UITextViewDelegate>
@property (nonatomic, strong) WeatherManager *weatherManager;

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.weatherManager = [[WeatherManager alloc] init];
    
    // Do any additional setup after loading the view.
    
    //[self getWeatherWithTextfield];
    }

-(void)getWeatherWithTextfield
{
    NSString *urlString = [[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&APPID=c5d4c2e7b159d4fa7b5dddd06d157141", self.textField.text] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self.weatherManager getWeatherWithURL:urlString controller:self completion:^(id responseObject) {
        NSError *error;
        WeatherUpdate *weather = [[WeatherUpdate alloc] initWithDictionary:responseObject error:&error];
        NSLog(@"%@",weather);
        
        [self updateUIWithJSON:weather];
        
    }];
}

-(void)updateUIWithJSON:(WeatherUpdate *)weather {
    self.tempLabel.text = [NSString stringWithFormat:@"%ld", (long)weather.temp];
    self.weatherlabel.text = ((Weather *)weather.weather[0]).main;
    self.pressureLabel.text = [NSString stringWithFormat:@"Pressure:\n%.0f", weather.pressure];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";
    self.sunsetLabel.text = [NSString stringWithFormat:@"Sunset:\n %@",[formatter stringFromDate:weather.sunset]];
    self.sunriseLabel.text = [NSString stringWithFormat:@"Sunrise:\n %@",[formatter stringFromDate:weather.sunrise]];
    self.windLabel.text = [NSString stringWithFormat:@"Wind:\n %.1f",weather.speed];
    
    if (self.tempLabel.text == nil) {
        self.tempLabel.hidden = YES;
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.textField resignFirstResponder];
    [self getWeatherWithTextfield];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)dissmisKeyboard:(id)sender {
}
@end
