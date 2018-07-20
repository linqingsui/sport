//
//  XSHomeViewController.m
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSHomeViewController.h"
#import "XSCommunityViewController.h"
#import "XSRankingListViewController.h"
#import "XSInformationViewController.h"
#import "XSCompetitionViewController.h"
#import "XSMySettingsViewController.h"

@interface XSHomeViewController (){
    XSCommunityViewController *communityViewController;
    XSRankingListViewController *rankingListViewController;
    XSInformationViewController *informationViewController;
    XSCompetitionViewController *competionViewController;
    XSMySettingsViewController *mySettingsViewController;
}

@end

@implementation XSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    competionViewController=[[XSCompetitionViewController alloc]initWithNibName:@"XSCompetitionViewController" bundle:nil];
    competionViewController.title=@"赛事";
    UINavigationController *navCompetionViewController=[[UINavigationController alloc]initWithRootViewController:competionViewController];

    
    rankingListViewController=[[XSRankingListViewController alloc]initWithNibName:@"XSRankingListViewController" bundle:nil];
    rankingListViewController.title=@"排名";
    UINavigationController *navRankingListViewController=[[UINavigationController alloc]initWithRootViewController:rankingListViewController];
    
    informationViewController=[[XSInformationViewController alloc]initWithNibName:@"XSInformationViewController" bundle:nil];
    informationViewController.title=@"资讯";
    UINavigationController *navInformationViewController=[[UINavigationController alloc]initWithRootViewController:informationViewController];
    
    communityViewController=[[XSCommunityViewController alloc]initWithNibName:@"XSCommunityViewController" bundle:nil];
    communityViewController.title=@"圈子";
    UINavigationController *navCommunityViewController=[[UINavigationController alloc]initWithRootViewController:communityViewController];
    
    mySettingsViewController=[[XSMySettingsViewController alloc]initWithNibName:@"XSMySettingsViewController" bundle:nil];
    mySettingsViewController.title=@"我的";
    UINavigationController *navMySettingsViewController=[[UINavigationController alloc]initWithRootViewController:mySettingsViewController];
//    communityViewController.tabBarItem.image = [[UIImage imageNamed:@"file_11"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    communityViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"file_12"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSArray *arr= [ NSArray arrayWithObjects:navCompetionViewController,navRankingListViewController,navInformationViewController,navCommunityViewController,navMySettingsViewController, nil];
    [self setViewControllers:arr];

    
    self.tabBar.barTintColor=kMainColor;
    self.tabBar.tintColor=kDeepMainColor;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                                       NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary
                                                       dictionaryWithObjectsAndKeys:kDeepMainColor,
                                                       NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
