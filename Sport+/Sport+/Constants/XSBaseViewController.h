//
//  XSBaseViewController.h
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSBaseViewController : UIViewController
-(void)animateTextField: (id) textField up: (BOOL) up movementDistance:(int) movementDistance;
-(void)PresentShouldBackTo;
-(void)presentBackTo:(UIButton *)sender;
-(void)PushShouldBackTo;
-(BOOL)checkToLogin;
-(void)AutoBackTo;
-(void)pushBackTo:(UIButton *)sender;
- (void)AutoBack:(id)sender;
@end
