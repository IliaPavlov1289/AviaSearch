//
//  TicketsViewController.h
//  AviaSearch
//
//  Created by Илья Павлов on 01.08.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum FavoriteType {
    FavoriteTypeList,
    FavoriteTypeMap
} FavoriteType;

@interface TicketsViewController : UITableViewController

- (instancetype)initWithTickets:(NSArray *)tickets;
- (instancetype)initFavoriteTicketsController;

@end

NS_ASSUME_NONNULL_END
