//
//  XSCompetitionTableViewController.m
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSCompetitionTableViewController.h"
#import "XSListByDateJsonModel.h"
#import "FFMNetworking.h"
#import "SVProgressHUD.h"
#import "XSCompetitionTableViewCell.h"
#import "NSDate+YYAdd.h"
#import "TOWebViewController.h"

@interface XSCompetitionTableViewController (){
    XSListByDateJsonModel *listByDateJsonModel;
    NSString *choosedDateString;
    NSDate *choosedDate;
}

@end

@implementation XSCompetitionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate=(id)self;
    self.tableView.dataSource=(id)self;
    self.tableView.backgroundColor=kBGColor;
    UITapGestureRecognizer *view_leftDate_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view_leftDateClick:)];
    [_view_leftDate addGestureRecognizer:view_leftDate_tap];
    
    UITapGestureRecognizer *view_rightDate_tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view_rightDateClick:)];
    [_view_rightDate addGestureRecognizer:view_rightDate_tap];
    [self toToday];
    [self MyLoadHeaderData];
    // Do any additional setup after loading the view from its nib.
}
-(void)view_leftDateClick:(UITapGestureRecognizer *)tap{
    choosedDate=[choosedDate dateByAddingDays:-1];
    choosedDateString=[choosedDate stringWithFormat:@"yyyy-MM-dd"];
    _label_todayDate.text=choosedDateString;
    _label_leftDate.text=[[choosedDate dateByAddingDays:-1] stringWithFormat:@"yyyy-MM-dd"];
    _label_rightDate.text=[[choosedDate dateByAddingDays:1] stringWithFormat:@"yyyy-MM-dd"];
    [self MyLoadHeaderData];
}
-(void)view_rightDateClick:(UITapGestureRecognizer *)tap{
    choosedDate=[choosedDate dateByAddingDays:1];
    choosedDateString=[choosedDate stringWithFormat:@"yyyy-MM-dd"];
    _label_todayDate.text=choosedDateString;
    _label_leftDate.text=[[choosedDate dateByAddingDays:-1] stringWithFormat:@"yyyy-MM-dd"];
    _label_rightDate.text=[[choosedDate dateByAddingDays:1] stringWithFormat:@"yyyy-MM-dd"];
    [self MyLoadHeaderData];
}
-(void)toToday{
    choosedDate=[NSDate date];
    choosedDateString=[choosedDate stringWithFormat:@"yyyy-MM-dd"];
    _label_todayDate.text=choosedDateString;
    _label_leftDate.text=[[choosedDate dateByAddingDays:-1] stringWithFormat:@"yyyy-MM-dd"];
    _label_rightDate.text=[[choosedDate dateByAddingDays:1] stringWithFormat:@"yyyy-MM-dd"];
}
- (IBAction)btn_today_click:(id)sender {
    [self toToday];
    [self MyLoadHeaderData];
}
-(void)LQSSetTableViewSize
{
    TableViewSize=CGRectMake(0, 44, KDWidth, KDHeight-64-50-44-44);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)MyLoadHeaderData{
    [[FFMNetworking manager] GET:[NSString stringWithFormat:@"%@%@",QQSportBasePath,@"match/listByDate"] param:[NSDictionary dictionaryWithObjectsAndKeys:choosedDateString,@"date", nil] JSONModelClass:[XSListByDateJsonModel class] success:^(NSURLSessionTask *operation, id responseObject) {
        listByDateJsonModel=responseObject;
        if([listByDateJsonModel.code isEqualToNumber:@0]){
            
        }
        [self headEndRefresh];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        [self headEndRefresh];
        [SVProgressHUD showErrorWithStatus:@"服务器忙，稍后重试。"];
    }];
}
-(void)MyLoadfooterData{
    [self footEndRefresh];
}
#pragma mark - 表格视图数据源代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listByDateJsonModel.data.matches.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XSCompetitionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"XSCompetitionTableViewCell"];
    cell.opaque=YES;
    if (cell==nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"XSCompetitionTableViewCell" owner:nil options:nil];
        for (id oneObject in nib)
        {
            if ([oneObject isKindOfClass:[XSCompetitionTableViewCell class]])
            {
                cell = (XSCompetitionTableViewCell *)oneObject;
            }
        }
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.matchesItemJsonModel=listByDateJsonModel.data.matches[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TOWebViewController *toWebViewController=[[TOWebViewController alloc]initWithURLString:[NSString stringWithFormat:@"%@%@",@"http://sports.qq.com/kbsweb/game.htm?mid=",[[listByDateJsonModel.data.matches[indexPath.row] matchInfo] mid]]];
    toWebViewController.title=@"观看视频";
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:toWebViewController];
    [self presentViewController:nav animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
