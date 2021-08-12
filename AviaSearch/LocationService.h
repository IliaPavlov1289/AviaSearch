//
//  LocationService.h
//  AviaSearch
//
//  Created by Илья Павлов on 03.08.2021.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define kLocationServiceDidUpdateCurrentLocation @"LocationServiceDidUpdateCurrentLocation"

NS_ASSUME_NONNULL_BEGIN

@interface LocationService : NSObject <CLLocationManagerDelegate>

@end

NS_ASSUME_NONNULL_END
