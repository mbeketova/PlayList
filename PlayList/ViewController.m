//
//  ViewController.m
//  PlayList
//
//  Created by Admin on 06.07.15.
//  Copyright (c) 2015 Mariya Beketova. All rights reserved.

//-----------------------------------------------------------

/*Задача: есть сервер, раздающий информацию о песни в виде JSON формате. Каждая песня состоит из следующих полей:
1. Название песни(строка)
2. Автор песни(строка)
3. id песни(число)

Приложение должно скачивать песни, сохранять их в БД(желательно, CoreData) и выводить в виде таблицы, где каждая ячейка состоит из Названия + Автора.

Так же необходимо предусмотреть жест PullToRefresh, который обновляет с сервера данные таблицы.
Важным аспектом должно являться то, что новый список может как содержать новые песни, так и не иметь уже некоторых ранее загруженных. В случае, если при обновлении станет ясно, что часть песен удалилась с сервера, то их так же требуется удалить из таблицы и из базы.

Простым reloadData, естественно, не надо этот вопрос решать. Должны анимировано удаляться и добавляться ячейки.

Приветствуется использование third-party инструментов, ускоряющих работу. Голую CoreData можешь даже не показывать.

http://kilograpp.com:8080/songs/api/songs - запрос на получение песен
http://kilograpp.com:8080/songs/ - админка для добавления/удаления*/

//-----------------------------------------------------------------
/*
 В работе использованы сторонние библиотеки: AFNetworking, MagicalRecord
 */
//-----------------------------------------------------------------

#import "ViewController.h"
#import "ManagerAPI.h"
#import "CustomTableViewCell.h"
#import "SingsDetails.h"


#define     URL_METOD   @"songs"
#define     AUTHOR      @"author"
#define     LABEL       @"label"


@interface ViewController () <ManagerAPIDelegate>


@property (nonatomic, strong) NSMutableArray * arrayPlayList;
@property (nonatomic, weak) NSArray * arraySearchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL isSearchBarActive;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrayPlayList = [[NSMutableArray alloc]init];
    self.isSearchBarActive = NO;
    //запрос к серверу (описан в отдельном классе: ManagerAPI)
    [[ManagerAPI managerWithDelegate:self]getDataFromWall:URL_METOD];
   
    //RefreshControl:
    UIView * refreshView = [[UIView alloc]initWithFrame:CGRectMake(0, 55, 0, 0)];
    [self.tableView addSubview:refreshView];
    UIRefreshControl * refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(refreshingPlayList:) forControlEvents:UIControlEventValueChanged];
    NSMutableAttributedString * refreshString = [[NSMutableAttributedString alloc]initWithString:@"Обновление..."];
    [refreshString addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
    refreshControl.attributedTitle = refreshString;
    [refreshView addSubview:refreshControl];
    
}

#pragma-mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayPlayList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.label_Author.text = [[self.arrayPlayList objectAtIndex:indexPath.row]objectForKey:AUTHOR];
    cell.label_Song.text = [[self.arrayPlayList objectAtIndex:indexPath.row]objectForKey:LABEL];
    return cell;
}


#pragma mark - RefreshMetod

- (void) refreshingPlayList: (UIRefreshControl*)refresh {
    [self.arrayPlayList removeAllObjects];
    [[ManagerAPI managerWithDelegate:self]getDataFromWall:URL_METOD];
    [refresh endRefreshing];
}

#pragma mark - ReloadTableView

- (void) reload_TableView {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];});
}

#pragma mark - ManagerAPIDelegate

- (void) response: (ManagerAPI *) manager Answer: (id) respObject{
    
    NSArray *arrayList = respObject;
    [self deleteSings:arrayList];
    [self addSings:arrayList];
    [self addArraPlayList:arrayList];
    [self reload_TableView];
}

- (void) responseError: (ManagerAPI *) manager Error: (NSError *) error{
    NSLog(@"%@", error);
    
}

#pragma mark - CoreDataMagic

- (void) deleteSings: (NSArray*)arrayOfSingData {
    NSArray *arraySing = [SingsDetails MR_importFromArray:arrayOfSingData];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT(id IN %@)", arrayOfSingData];
    [SingsDetails MR_deleteAllMatchingPredicate:predicate];
}

- (void) addSings: (NSArray*) arrayList {
    for (int i = 0; i < arrayList.count; i++) {
        NSDictionary *listInfo = [arrayList objectAtIndex:i];
        SingsDetails *sings = [SingsDetails MR_createEntity];
        [sings MR_importValuesForKeysWithObject:listInfo];
    }
}

- (void) addArraPlayList: (NSArray*)arrayList{
    NSArray * arrayListExsctract = [SingsDetails MR_findAll];
    for (int i = 0; i < arrayListExsctract.count; i++) {
        NSDictionary *listInfo = [arrayList objectAtIndex:i];
        [self.arrayPlayList addObject:listInfo];
    }

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
