//
//  XSBaseViewController.m
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import "XSBaseViewController.h"

@interface XSBaseViewController ()

@end

@implementation XSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)AutoBackTo{
    if (self.navigationController.viewControllers.count>1) {
        [self PushShouldBackTo];
    }
    else{
        [self PresentShouldBackTo];
    }
}
- (void)PresentShouldBackTo {
    [self becomeFirstResponder];

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 20,20);
    [backBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(presentBackTo:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)PushShouldBackTo {
    [self becomeFirstResponder];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backarrow"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(pushBackTo:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)AutoBack:(id)sender {
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)presentBackTo:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)pushBackTo:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//在UITextField 编辑之前调用方法
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self animateTextField: textField up: YES movementDistance:150];
}
//在UITextField 编辑完成调用方法
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField: textField up: NO movementDistance:150];
}
//视图上移的方法
- (void) animateTextField: (id) textField up: (BOOL) up movementDistance:(int) movementDistance
{
    //三目运算，判定是否需要上移视图或者不变
    int movement = (up ? -movementDistance : movementDistance);
    //设置动画的名字
    [UIView beginAnimations: @"Animation" context: nil];
    //设置动画的开始移动位置
    [UIView setAnimationBeginsFromCurrentState: YES];
    //设置动画的间隔时间
    [UIView setAnimationDuration: 0.20];
    //设置视图移动的位移
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    //设置动画结束
    [UIView commitAnimations];
}
//使键盘弹回的方法，输入触摸的方法：
//点击屏幕，让键盘弹回
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
