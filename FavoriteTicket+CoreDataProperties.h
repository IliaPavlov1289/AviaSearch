//
//  FavoriteTicket+CoreDataProperties.h
//  AviaSearch
//
//  Created by Илья Павлов on 12.08.2021.
//
//

#import "FavoriteTicket+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nonatomic) int16_t flightNumber;
@property (nullable, nonatomic, copy) NSString *from;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSString *to;
@property (nonatomic) BOOL addFromList;

@end

NS_ASSUME_NONNULL_END
