//
//  TicketsViewController.m
//  AviaSearch
//
//  Created by Илья Павлов on 01.08.2021.
//

#import "TicketsViewController.h"
#import "TicketTableViewCell.h"
#import "CoreDataHelper.h"


#define TicketCellReuseIdentifier @"TicketCellIdentifier"

@interface TicketsViewController ()

@property (nonatomic, strong) NSArray *tickets;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation TicketsViewController {
    BOOL isFavorites;
}

- (instancetype)initFavoriteTicketsController{
    self = [super init];
    if (self) {
        isFavorites = YES;
        self.tickets = [NSArray new];
        self.title = @"Избранное";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

- (instancetype)initWithTickets:(NSArray *)tickets {
    self = [super init];
    if (self)
    {
        _tickets = tickets;
        self.title = @"Билеты";
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[TicketTableViewCell class] forCellReuseIdentifier:TicketCellReuseIdentifier];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (isFavorites) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        [self changeSource];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (isFavorites){
        
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Список", @"Карта"]];
        [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.tintColor = [UIColor blackColor];
        self.navigationItem.titleView = _segmentedControl;
        _segmentedControl.selectedSegmentIndex = 0;
        [self changeSource];
        
    }
}

- (void)changeSource {
    NSPredicate *predAddFromList = [NSPredicate predicateWithFormat:@"addFromList == YES"];
    NSPredicate *predAddFromMap = [NSPredicate predicateWithFormat:@"addFromList == NO"];
    NSArray *favorites = [[CoreDataHelper sharedInstance] favorites];
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            _tickets = [favorites filteredArrayUsingPredicate:predAddFromList];
            break;
        case 1:
            _tickets = [favorites filteredArrayUsingPredicate:predAddFromMap];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _tickets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TicketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TicketCellReuseIdentifier forIndexPath:indexPath];
    if (isFavorites) {
        cell.favoriteTicket = [_tickets objectAtIndex:indexPath.row];
    } else {
        cell.ticket = [_tickets objectAtIndex:indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Действия с билетом" message:@"Что необходимо сделать с выбранным билетом?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *favoriteAction;
    if (isFavorites) {
            favoriteAction = [UIAlertAction actionWithTitle:@"Удалить из избранного" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                [[CoreDataHelper sharedInstance] removeFromFavorite:[self->_tickets objectAtIndex:indexPath.row]];
                [self changeSource];
            }];
        [alertController addAction:favoriteAction];
    }
    else if ([[CoreDataHelper sharedInstance] isFavorite: [_tickets objectAtIndex:indexPath.row]]) {
        alertController.title = @"Добавление невозможно";
        alertController.message = @"Билет уже был добавлен в избранноe";
    } else {
        favoriteAction = [UIAlertAction actionWithTitle:@"Добавить в избранное" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[CoreDataHelper sharedInstance] addToFavorite:[self->_tickets objectAtIndex:indexPath.row] addFromList:YES];
        }];
        [alertController addAction:favoriteAction];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Закрыть" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
