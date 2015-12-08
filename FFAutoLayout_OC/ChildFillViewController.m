//
//  ChildFillViewController.m
//  FFAutoLayout_OC
//
//  Created by LXF on 15/10/18.
//  Copyright © 2015年 Xiaofeng Li . All rights reserved.
//

#import "ChildFillViewController.h"
#import "UIView+AutoLayout.h"

@interface ChildFillViewController ()

@end

@implementation ChildFillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:contentView];
    
    [contentView xx_FillWithType:xx_FillTypeTop referView:self.view constant:200 insets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    UIView *blueV = [[UIView alloc]init];
    blueV.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:blueV];
    
    UIView *redV = [[UIView alloc]init];
    redV.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redV];
  
    UIView *yellowV = [[UIView alloc]init];
    yellowV.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:yellowV];
    
    [contentView xx_VerticalTileWithSubviews:@[blueV,yellowV,redV] insets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

- (void)setAccessibilit{
    //ghjklkjghjklkjhg
}

@end
