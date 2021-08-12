//
//  TicketTableViewCell.h
//  AviaSearch
//
//  Created by Илья Павлов on 01.08.2021.
//

#import <UIKit/UIKit.h>
#import "DataManager.h"
#import "APIManager.h"
#import "Ticket.h"
#import "FavoriteTicket+CoreDataClass.h"
#import "FavoriteTicket+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicketTableViewCell : UITableViewCell

@property (nonatomic, strong) Ticket *ticket;
@property (nonatomic, strong) FavoriteTicket *favoriteTicket;

@end

NS_ASSUME_NONNULL_END
