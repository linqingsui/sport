//
//  XSBaseTableViewController.m
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSBaseTableViewController.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"
@interface XSBaseTableViewController ()

@end

@implementation XSBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LQSSetTableViewSize];
    // Custom initialization
    _tableView=[[UITableView alloc]initWithFrame:TableViewSize style:UITableViewStylePlain];
    //    // ios7cell分割线短些解决办法
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // 隐藏多余的cell分割线
    [self setExtraCellLineHidden:_tableView];
    //  [self.view setBackgroundColor:[UIColor yellowColor]];
    //  _tableView.backgroundColor=[UIColor redColor];
    [self.view addSubview:_tableView];
    [self setupRefresh];
    
    // Do any additional setup after loading the view.
}
#pragma mark 隐藏多余的cell分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}

/**
 为了保证内部不泄露，在dealloc中释放占用的内存
 */
- (void)dealloc
{
    NSLog(@"MJTableViewController--dealloc---");
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    
    if (!self.tableView.header) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
        //#warning 自动刷新(一进入程序就下拉刷新)
    }
    if (!self.tableView.footer) {
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    }
    //   [self.tableView headerBeginRefreshing];
    
    
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"正在刷新中...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据";
    self.tableView.footerRefreshingText = @"正在帮你加载中...";
}

#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    // 1.添加假数据
    [self MyLoadHeaderData];
    
    //    // 2.2秒后刷新表格UI
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //        // 刷新表格
    //        [self.tableView reloadData];
    //
    //        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    //        [self.tableView headerEndRefreshing];
    //    });
}

- (void)footerRereshing
{
    // 1.添加假数据
    
    [self MyLoadfooterData];
    // 2.2秒后刷新表格UI
    
}
-(void) footEndRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView footerEndRefreshing];
    });
}
-(void) headEndRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [self.tableView headerEndRefreshing];
    });
}
-(void)MyLoadfooterData
{
    [self footEndRefresh];
}
-(void)MyLoadHeaderData
{
    [self headEndRefresh];
}
-(void)LQSSetTableViewSize
{
    TableViewSize=CGRectMake(0, 0, KDWidth, KDHeight-KDNavAndStatusHight);
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
