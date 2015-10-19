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
    
    UIView *blueV = [[UIView alloc]init];
    blueV.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:blueV];
    
    UIView *redV = [[UIView alloc]init];
    redV.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:redV];
  
    UIView *yellowV = [[UIView alloc]init];
    yellowV.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:yellowV];
    
    [self.view ff_VerticalTileWithSubviews:@[blueV,yellowV,redV] insets:UIEdgeInsetsMake(10, 10, 10, 10)];
}
@end