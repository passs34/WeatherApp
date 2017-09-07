//
//  WeekWeatherUpdate.m
//  Weather
//
//  Created by pasyukevich on 06.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "WeekWeatherUpdate.h"

@implementation WeekWeatherUpdate

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"weather": @"list",
                                                                  }];
}

@end
