//
//  WeekWeatherUpdate.h
//  Weather
//
//  Created by pasyukevich on 06.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WeatherUpdate.h"

@interface WeekWeatherUpdate : JSONModel

@property (nonatomic) NSArray <WeatherUpdate> *weather;

@end
