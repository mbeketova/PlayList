//
//  TableViewController.m
//  PlayList
//
//  Created by Admin on 07.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (nonatomic, strong) NSMutableArray * arrayPlayList;
@property (nonatomic, strong) IBOutlet UITableView * tableView;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayPlayList = [[NSMutableArray alloc]init];
    UIRefreshControl * refreshControl = [[UIRefreshControl alloc]init];
    [refreshControl addTarget:self action:@selector(refreshControlView:) forControlEvents:UIControlEventValueChanged];
    [self managerAPI];
    [refreshControl endRefreshing];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayPlayList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * simpleTableIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        }
    cell.textLabel.text = [[self.arrayPlayList objectAtIndex: indexPath.row]objectForKey:@"author"];
    cell.detailTextLabel.text = [[self.arrayPlayList objectAtIndex:indexPath.row]objectForKey:@"label"];
    return cell;

}

#pragma mark Metods

- (void) getData: (NSData*)data {
    self.arrayPlayList = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    [self.tableView reloadData];
}

- (void) managerAPI {
    NSString * urlString = [NSString stringWithFormat:@"http://kilograpp.com:8080/songs/api/songs"];
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [NSData dataWithContentsOfURL:url];
    [self getData:data];

   }

- (void) refreshControlView: (UIRefreshControl*)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"Refreshing data...."];
    NSLog(@"Refreshing");
    [self managerAPI];
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"MMM d, h:mm a"];
    NSString * lastUpdated = [NSString stringWithFormat:@"Last updated on %@",
                              [format
                               stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:lastUpdated];
    [refresh endRefreshing];
}

@end
