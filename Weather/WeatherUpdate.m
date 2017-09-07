//
//  WeatherUpdate.m
//  Weather
//
//  Created by pasyukevich on 06.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "WeatherUpdate.h"
#import "WeatherViewController.h"

@interface WeatherUpdate ()

@end

@implementation WeatherUpdate

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"city": @"name",
                                                                  @"temp": @"main.temp",
                                                                  @"weather": @"weather",
                                                                  @"speed": @"wind.speed",
                                                                  @"sunrise": @"sys.sunrise",
                                                                  @"sunset": @"sys.sunset",
                                                                  @"pressure": @"main.pressure",
                                                                  @"dayWeek": @"dt"
                                                                  }];
}

@end
