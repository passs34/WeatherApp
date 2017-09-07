//
//  WeatherUpdate.h
//  Weather
//
//  Created by pasyukevich on 06.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "Weather.h"

@protocol WeatherUpdate;
@interface WeatherUpdate : JSONModel

@property (nonatomic) NSString <Optional> *city;
@property (nonatomic) NSInteger temp;
@property (nonatomic) NSArray <Weather> *weather;
@property (nonatomic) double speed;
@property (nonatomic) NSDate <Optional> *sunrise;
@property (nonatomic) NSDate <Optional> *sunset;
@property (nonatomic) double pressure;
@property (nonatomic) NSDate <Optional> *dayWeek;

@end
