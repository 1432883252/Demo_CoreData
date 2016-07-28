//
//  ViewController.m
//  Demo_CoreData
//
//  Created by wangpanpan on 16/7/22.
//  Copyright © 2016年 wangpanpan. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
#import "NewsCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView *contentTV;

@end

@implementation ViewController
- (UITableView *)contentTV{
    if (_contentTV == nil) {
        self.contentTV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _contentTV.dataSource = self;
        _contentTV.delegate = self;
        _contentTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  _contentTV;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.contentTV];
    
    NSLog(@"%@",NSHomeDirectory());
    _coredataManager = [[CoreDataManager alloc]init];
    
    //更新时间
    NSString *updateDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"updateDate"];
    if (!updateDate) {
        //如果无此对象，表示第一次，那么就读取数据写入数据库中
        [self writeData];
    }else{
        //有此对象说明只要从数据库中读取数据
        NSTimeInterval update = updateDate.doubleValue;
        NSTimeInterval now = [NSDate timeIntervalSinceReferenceDate];
        //8小时更新一次
        if ((now - update) > 8*60*60) {
            //超过8小时，清空数据库，重新写入
            [_coredataManager delegateData];
            [self writeData];
        }else{
            //没有超过8小时，直接从数据库读取数据
            NSMutableArray *array = [_coredataManager selectData:10 andOffset:0];
            _resultArray = [NSMutableArray arrayWithArray:array];
            [_contentTV reloadData];
            
        }
    }
    
}

#pragma mark - coredata -

- (void)writeData{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",[NSDate timeIntervalSinceReferenceDate]] forKey:@"updateDate"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //读取信息
    NSString *path = [[NSBundle mainBundle]pathForResource:@"News" ofType:@"txt"];
    NSString *data = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *array = [data objectFromJSONString];
    _resultArray = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        News *newsInfo = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:_coredataManager.managedObjectContext];
        newsInfo.newsid = [dict objectForKey:@"id"];
        newsInfo.title = [dict objectForKey:@"title"];
        newsInfo.imgurl = [dict objectForKey:@"imgurl"];
        newsInfo.descr = [dict objectForKey:@"descr"];
        newsInfo.islook = @"0";//0表示没有看过此条新闻
        [_resultArray addObject:newsInfo];
    }
    //把数据写到数据库
    [_coredataManager insertCoreData:_resultArray];
    [_contentTV reloadData];
}

#pragma mark - UITableView -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"NewsCell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *cells = [[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:self options:nil];
        cell = [cells lastObject];
    }
    News *info = [_resultArray objectAtIndex:indexPath.row];
    [cell setContent:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当你点击时说明要看此条新闻，那么就标注此新闻已被看过
    News *info = [_resultArray objectAtIndex:indexPath.row];
    info.islook = @"1";
    //改变数据库查看状态
    [_coredataManager updateData:info.newsid withIsLook:@"1"];
    //改变resultarry数据
    [_resultArray setObject:info atIndexedSubscript:indexPath.row];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
