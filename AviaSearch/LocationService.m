//
//  LocationService.m
//  AviaSearch
//
//  Created by Илья Павлов on 03.08.2021.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface LocationService() <CLLocationManagerDelegate>

    @property (nonatomic, strong) CLLocationManager *locationManager;
    @property (strong, nonatomic) CLLocation *currentLocation;

@end

@implementation LocationService

- (instancetype)init
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
    }
    return self;
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager  {
    if (manager.authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || manager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
    } else if (manager.authorizationStatus != kCLAuthorizationStatusNotDetermined) {
        NSLog(@"StatusNotDetermined");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    if (!_currentLocation) {
        _currentLocation = [locations firstObject];
        [_locationManager stopUpdatingLocation];
        [[NSNotificationCenter defaultCenter] postNotificationName:kLocationServiceDidUpdateCurrentLocation object:_currentLocation];
    }
}

@end
