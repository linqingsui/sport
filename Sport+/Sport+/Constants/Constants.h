//
//  Constants.h
//  Sport+
//
//  Created by 林庆遂 on 2018/3/27.
//  Copyright © 2018年 林庆遂. All rights reserved.
//

#define kMainColor UIColorFromRGB(0x3ad07e)
#define kDeepMainColor UIColorFromRGB(0x008B00)
#define kGrayColor UIColorFromRGB(0xBDBDBD)
#define kLightGrayColor UIColorFromRGB(0xc9c9c9)
#define kFontColor UIColorFromRGB(0x626262)
#define kBGColor UIColorFromRGB(0xF6F2F2)

#pragma mark ----------- 设备相关 ---------------
#define KDVersion   [[[UIDevice currentDevice] systemVersion] floatValue]
#define KDHeight     [UIScreen mainScreen].bounds.size.height
#define KDWidth      [UIScreen mainScreen].bounds.size.width
#define KDStatusRect  [[UIApplication sharedApplication] statusBarFrame].size.height
#define KDNavRect  self.navigationController.navigationBar.frame.size.height
#define KDNavAndStatusHight  KDStatusRect+KDNavRect
#define KDTabBarHeight  self.tabBar.frame.size.height

#pragma mark 十六进制颜色
#define  UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define QQSportBasePath @"http://sportsnba.qq.com/"
#define BasePath @""
