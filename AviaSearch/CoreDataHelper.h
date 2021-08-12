//
//  CoreDataHelper.h
//  AviaSearch
//
//  Created by Илья Павлов on 08.08.2021.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "DataManager.h"
#import "Ticket.h"

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataHelper : NSObject

+ (instancetype)sharedInstance;

- (BOOL)isFavorite:(Ticket *)ticket;
- (NSArray *)favorites;
- (void)addToFavorite:(Ticket *)ticket addFromList:(BOOL)addFromList;
- (void)removeFromFavorite:(Ticket *)ticket;

@end

NS_ASSUME_NONNULL_END
