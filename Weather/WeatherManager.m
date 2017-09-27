//
//  WeatherManager.m
//  Weather
//
//  Created by pasyukevich on 09.09.17.
//  Copyright © 2017 pasyukevich. All rights reserved.
//

#import "WeatherManager.h"
#import <AFNetworking.h>
#import "LocationManager.h"

@implementation WeatherManager

-(void)showErrorAlert:(NSError*)error controller:(UIViewController*)controller {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
       UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
       [alert addAction:action];
    [controller presentViewController:alert animated:YES completion:nil];
}

-(void)getWeatherWithURL:(NSString *)url controller:(UIViewController*)controller completion:(void (^)(id responseObject))completion {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        completion(responseObject); 
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self showErrorAlert:error controller:controller];
    }];
}

-(void)showErrorServerAlert:(NSError*)error controller:(UIViewController*)controller {
    
    UIAlertController *serverAlert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Repeat request???" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionBotton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
    [[LocationManager sharedInstance] startUpdatingLocation];
    }];
    [serverAlert addAction:actionBotton];
    [controller presentViewController:serverAlert animated:YES completion:nil];
}

@end
