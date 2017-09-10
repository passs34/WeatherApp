//
//  WeatherManager.h
//  Weather
//
//  Created by pasyukevich on 09.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WeatherManager : NSObject

-(void)showErrorAlert:(NSError*)error controller:(UIViewController*)controller;
-(void)getWeatherWithURL:(NSString *)url controller:(UIViewController*)controller completion:(void (^)(id responseObject))completion;

@end
