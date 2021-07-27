//
//  PlaceViewController.h
//  AviaSearch
//
//  Created by Илья Павлов on 25.07.2021.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"

typedef enum PlaceType {
    PlaceTypeArrival,
    PlaceTypeDeparture
} PlaceType;


@protocol PalceViewControllerDelegate <NSObject>

-(void)selectPlace:(id)place withType:(PlaceType)placeType andDataType:(DataSourceType)dataType;

@end


@interface PlaceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) id<PalceViewControllerDelegate>delegate;
-(instancetype)initWithType:(PlaceType)type;

@end
