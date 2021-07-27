//
//  PlaceViewController.m
//  AviaSearch
//
//  Created by Илья Павлов on 25.07.2021.
//

#import "PlaceViewController.h"
#define reuseIdentifierCellIdentifier @"CellIdentifier"


@interface PlaceViewController ()
    @property (nonatomic) PlaceType placeType;
    @property (nonatomic, strong) UITableView *tableView;
    @property (nonatomic, strong) UISegmentedControl *segmentedControl;
    @property (nonatomic, strong) NSArray *currentArray;

@end


@implementation PlaceViewController

-(instancetype)initWithType:(PlaceType)type {
    self = [super init];
    if (self) {
        _placeType = type;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview: _tableView];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Cities", @"Airports"]];
    [_segmentedControl addTarget:self action:@selector(changeSource) forControlEvents:UIControlEventValueChanged];
    _segmentedControl.tintColor = [UIColor blackColor];
    self.navigationItem.titleView = _segmentedControl;
    _segmentedControl.selectedSegmentIndex = 0;
    [self changeSource];
    
    if (_placeType == PlaceTypeDeparture) {
        self.title = @"From";
    }
    else {
        self.title = @"Where";
    }
   
}




-(void) changeSource {
    switch (_segmentedControl.selectedSegmentIndex) {
        case 0:
            _currentArray = [[DataManager sharedInstance] cities];
            break;
        case 1:
            _currentArray = [[DataManager sharedInstance] airports];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}





- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifierCellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifierCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        City *city = [_currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = city.name;
        cell.detailTextLabel.text = city.code;
    }
    else if (_segmentedControl.selectedSegmentIndex == 1) {
        Airport *airport = [_currentArray objectAtIndex:indexPath.row];
        cell.textLabel.text = airport.name;
        cell.detailTextLabel.text = airport.code;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_currentArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    DataSourceType dataType = ((int) _segmentedControl.selectedSegmentIndex) + 1;
    [self.delegate selectPlace:[_currentArray objectAtIndex:indexPath.row] withType:_placeType andDataType:dataType];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
