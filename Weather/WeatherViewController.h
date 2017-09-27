//
//  WeatherViewController.h
//  Weather
//
//  Created by pasyukevich on 05.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WeatherViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelCity;
@property (weak, nonatomic) IBOutlet UILabel *labelTemp;
@property (weak, nonatomic) IBOutlet UILabel *labelWeather;
@property (weak, nonatomic) IBOutlet UILabel *labelWind;
@property (weak, nonatomic) IBOutlet UILabel *labelPressure;
@property (weak, nonatomic) IBOutlet UILabel *labelSunrise;
@property (weak, nonatomic) IBOutlet UILabel *labelSunset;

@property (nonatomic, readonly) BOOL isEmpty;

@end
