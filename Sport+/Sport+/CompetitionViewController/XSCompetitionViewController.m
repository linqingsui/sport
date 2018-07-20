//
//  XSCompetitionViewController.m
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSCompetitionViewController.h"
#import "XSCompetitionTableViewController.h"
#import "UINavigationBar+Addition.h"

@interface XSCompetitionViewController (){
    NSMutableArray *rootViewNeedreLoad;
    BOOL _isLeftScroll;
    float _userContentOffsetX;
    XSCompetitionTableViewController *competitionTableViewController;
    
}

@end

@implementation XSCompetitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rootViewNeedreLoad=[[NSMutableArray alloc]initWithArray:@[@"0",@"0"]];
    _scrollView.contentSize=CGSizeMake(KDWidth*2, 0);
    _scrollView.delegate=(id)self;
    _btn_search.layer.cornerRadius=4;
    _btn_search.layer.borderWidth=1.0;
    _btn_search.layer.borderColor=kLightGrayColor.CGColor;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar hideBottomHairline];
    if (!_selectedNumber) {
        _selectedNumber=@"0";
    }
    [self initUIWithNumber:0];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 25, 25);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"search_white"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(btn_search_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUIWithNumber:(NSUInteger)number{
    for (int i=0; i<2; i++) {
        if (i==[_selectedNumber integerValue]) {
            [(UIView *)[_topView viewWithTag:201+i] setHidden:NO];
            [(UIButton *)[_topView viewWithTag:101+i] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        else{
            [(UIView *)[_topView viewWithTag:201+i] setHidden:YES];
            [(UIButton *)[_topView viewWithTag:101+i] setTitleColor:[UIColor colorWithWhite:1 alpha:0.8] forState:UIControlStateNormal];
        }
        
    }
    if ([rootViewNeedreLoad[number] isEqualToString:@"0"]) {
        if(number==0){
        competitionTableViewController=[[XSCompetitionTableViewController alloc]initWithNibName:@"XSCompetitionTableViewController" bundle:nil];
        competitionTableViewController.view.frame=CGRectMake(0+_scrollView.bounds.size.width*number, 0,
                                     _scrollView.bounds.size.width, _scrollView.bounds.size.height);
        [self addChildViewController:competitionTableViewController];
        [self.scrollView addSubview:competitionTableViewController.view];
        [rootViewNeedreLoad replaceObjectAtIndex:number withObject:@"1"];
        }
        [self.scrollView scrollRectToVisible:CGRectMake(0+_scrollView.bounds.size.width*number, 0,
                                                        _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
    }
    
}

- (IBAction)btn_click:(UIButton *)sender {
    NSInteger number=sender.tag-101;
    _selectedNumber=[NSString stringWithFormat:@"%ld",(long)number];
    [self initUIWithNumber:number];
    [self.scrollView scrollRectToVisible:CGRectMake(0+_scrollView.bounds.size.width*number, 0,
                                                    _scrollView.bounds.size.width, _scrollView.bounds.size.height) animated:YES];
}
- (IBAction)btn_search_click:(id)sender {
    //    SZUSchoolForPregnantSearchViewController *search=[[SZUSchoolForPregnantSearchViewController alloc]initWithNibName:@"SZUSchoolForPregnantSearchViewController" bundle:nil];
    //    [self.navigationController pushViewController:search animated:YES];
}


//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        //判断用户是否左滚动还是右滚动
        if (_userContentOffsetX <= scrollView.contentOffset.x) {
            _isLeftScroll = YES;
        }
        else {
            _isLeftScroll = NO;
        }
    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _scrollView) {
        if (_userContentOffsetX<=0&&scrollView.contentOffset.x<=0)
        {
        }else
            if(_isLeftScroll)
            {
                _selectedNumber=[NSString stringWithFormat:@"%d",(int)([_selectedNumber integerValue]+ceil((scrollView.contentOffset.x-_userContentOffsetX)/KDWidth)>1?1:[_selectedNumber integerValue]+ceil((scrollView.contentOffset.x-_userContentOffsetX)/KDWidth))];
                [self initUIWithNumber:[_selectedNumber integerValue]];
            }
            else{
                _selectedNumber=[NSString stringWithFormat:@"%d",(int)([_selectedNumber integerValue]-ceil((_userContentOffsetX-scrollView.contentOffset.x)/KDWidth)<0?0:[_selectedNumber integerValue]-ceil((_userContentOffsetX-scrollView.contentOffset.x)/KDWidth))];
                [self initUIWithNumber:[_selectedNumber integerValue]];
            }
    }
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
