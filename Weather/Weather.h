//
//  Weather.h
//  Weather
//
//  Created by pasyukevich on 06.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Weather;

@interface Weather : JSONModel

@property (nonatomic) NSString *main;

@end
