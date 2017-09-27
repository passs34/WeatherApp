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
#import "Urlmanagers.h"
@interface CityViewController () <UITextViewDelegate>
@property (nonatomic, strong) WeatherManager *weatherManager;

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.weatherManager = [[WeatherManager alloc] init];
    
    
    // Do any additional setup after loading the view.
    }

-(void)getWeatherWithTextfield
{
    NSString *urlString = [[NSString stringWithFormat:@"%@q=%@%@", BASEURL, self.textField.text, BASEURL2] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
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
